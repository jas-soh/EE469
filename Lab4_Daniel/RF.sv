/*  REG/DEC stage
	In this stage we are:
	- initializing the registerfile and outputing Da and Db
	- sign estended immediate values that may go into ALU
	- computing the branch value and sending that back to IF
	- main control unit here, outputting control signals
	
Inputs:
- clk
- instruction: current instruction
- instr_addr: PC 
- dataMem: output from dataMem, used for forwarding
- ALUOut: output from ALU, used for forwarding
- forwardOp: mux select from frowarding unit to choose which Da and Db to output 
- writeEnable: enable to write to register, input coming from last stage instruction
- writeData: data to write back to register coming from last stage instruction
- writeRegister: register to write to. coming from stage 5 instruction

Outputs:
- readA: output from port A of either register file, aluOut, or memOut
- readB: output from port B of either register file, aluOut, or memOut
- ALUSrc: control signal to choose between immediate or register
- ALUOp: control signal for ALU operation 
- memWrite_E: control signal to enable to write memory
- Mem2Reg: control to choose between ALU or mem to go to register data_in
- regWrite_E: control enable to write to register, used in last stage
- mem_read: control flag to read from memory
- setFlag: control flag to set the alu flags
- shiftSel: control flag used in stage 5 to decide choose reg write data_in
- sum_PCandImm: output summation of PC and branch immediates
- BrTaken: control signal to decide next PC
- Rd: rd portion of instruction, used for write register in stage 5

*/
`timescale 1ps/1ps
module RF(clk, instruction, instr_addr, dataMem, ALUOut, writeData, readA, readB, immVal,
		forwardOpA, forwardOpB, writeEnable, ALUSrc, ALUOp, memWrite_E, MemToReg, regWrite_E,
		sum_PCandImm, BrTaken, WriteRegister, Rd, mem_read, setFlag, shiftSel, shift_output, 
		negative, overflow, readRegB, forwardNeg, forwardOver, forwardOpflags);
	input logic clk, writeEnable, negative, overflow, forwardNeg, forwardOver, forwardOpflags;
	input logic [31:0] instruction;
	input logic [63:0] instr_addr, dataMem, ALUOut, writeData;
	input logic [1:0] forwardOpA, forwardOpB;
	input logic [4:0] WriteRegister;

	output logic [4:0] Rd, readRegB;
	output logic [2:0] ALUOp; 
	output logic ALUSrc, memWrite_E, MemToReg, regWrite_E, 
				BrTaken, mem_read, setFlag, shiftSel;
	output logic [63:0] readA, readB, sum_PCandImm, immVal, shift_output; 
	logic [63:0] SE_condAddr19, SE_BrAddr26, addr, imm12_ZE, imm9_SE;
	
	assign Rd = instruction[4:0];
	/*---------------------------- update PC -------------------------*/
	// sign extend condAddr19 and BrAddr26 then shift left by 2
	logic carry_PCandImm;
	
	// control flags that are used internally
	logic zeroFlag, Reg2Loc, UncondBr, immSize;
	// shift SE BrAddr26 and SE condAddr19
	shift2Left shift0 (.in({{38{instruction[25]}}, instruction[25:0]}), .out(SE_BrAddr26));
	shift2Left shift1 (.in({{45{instruction[23]}}, instruction[23:5]}), .out(SE_condAddr19));
	// 2:1 mux to choose immediate val
	wide_mux2_1  UncondBr_mux (.s0(UncondBr), .A(SE_condAddr19), .B(SE_BrAddr26), .OUT(addr));
	// adder with parameter WIDTH
	add_width PCandImm (.A(addr), .B(instr_addr), .cIn(1'b0), .s(sum_PCandImm), .cOut(carry_PCandImm));

	/* ------------------------ register file -------------------------*/

	// Register File - must be on negedge clk
	wide_mux2_1 #(5) reg_input_Ab (.s0(Reg2Loc), .A(instruction[4:0]), .B(instruction[20:16]), .OUT(readRegB));

	logic nClk;
	not #50 inv (nClk, clk);
	logic [63:0] Da_out, Db_out;
	// Register File - must be on negedge clk
	regfile regist (.ReadData1(Da_out), .ReadData2(Db_out), .WriteData(writeData), .ReadRegister1(instruction[9:5]),
					 .ReadRegister2(readRegB), .WriteRegister, .RegWrite(writeEnable), .clk(nClk));
					 
	/* ------------------------ immediate values ------------------------ */
	// sign extend imm12; zero extend imm9
	assign imm12_ZE = {{52'd0}, {instruction[21:10]}};
	assign imm9_SE = {{56{instruction[20]}}, {instruction[19:12]}};
	//2:1 mux to select immediate value
	wide_mux2_1 imm_sel (.s0(immSize), .A(imm9_SE), .B(imm12_ZE), .OUT(immVal));


	/* -------------------------- forwarding mux ------------------------- */
	// A - register
	// B - ALU output
	// C - mem output
	mux3_1 freshA (.A(Da_out), .B(ALUOut), .C(dataMem), .sel(forwardOpA), .OUT(readA));
	mux3_1 freshB (.A(Db_out), .B(ALUOut), .C(dataMem), .sel(forwardOpB), .OUT(readB));

	/* --------------------- check if Db is zero -------------------------- */

	logic [15:0] nors;
	genvar i;
	generate
		for (i = 0; i < 16; i++) begin : nor_gates
			// hold whether 4 consecutive bits are zero
			nor #50 zer (nors[i], readB[i*4], readB[i*4+1], readB[i*4+2], readB[i*4+3]);
		end
	endgenerate
	
	logic [3:0] ands;
	generate
		for (i = 0; i < 4; i++) begin : and_gates
			and #50 and0 (ands[i], nors[i*4], nors[i*4+1], nors[i*4+2], nors[i*4+3]);
		end
	endgenerate
	
	// ZERO check - not doing right thing
	and #50 out (zeroFlag, ands[0], ands[1], ands[2], ands[3]);

	/*------------------------- shifter -----------------------------------------*/
	// implement shifter
	shifter shif (.value(readA), .direction(1'b1), .distance(instruction[15:10]), .result(shift_output));

	/* -------------------------- control ---------------------------------------*/
	// make sure output control signals match with RF. need it to also be output of this module

	logic controlNeg, controlOverflow;
	// forwarding alu flags
	mux2_1 forwardmuxNeg (.s0(forwardOpflags), .a(negative), .b(forwardNeg), .out(controlNeg));
	mux2_1 forwardmuxOver (.s0(forwardOpflags), .a(overflow), .b(forwardOver), .out(controlOverflow));

	control cntl (.instr(instruction), .mem_read, .zeroFlag, .Reg2Loc, .ALUSrc, .MemToReg, 
					.RegWrite(regWrite_E), .MemWrite(memWrite_E), .BrTaken, .UncondBr, .ALUOp, .setFlag, 
					.immSize, .shiftSel, .negative(controlNeg), .overflow(controlOverflow));
					
endmodule


module RF_testbench();
	logic clk, writeEnable, negative, overflow;
	logic [31:0] instruction;
	logic [63:0] instr_addr, dataMem, ALUOut, writeData;
	logic [1:0] forwardOpA, forwardOpB;
	logic [4:0] WriteRegister;

	logic [4:0] Rd, readRegB;
	logic [2:0] ALUOp; 
	logic ALUSrc, memWrite_E, MemToReg, regWrite_E, 
				BrTaken, mem_read, setFlag, shiftSel;
	logic [63:0] readA, readB, sum_PCandImm, immVal, shift_output; 

	RF dut (.*);

	parameter ClockDelay = 10000;
   	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		
		$stop;
	end

endmodule
