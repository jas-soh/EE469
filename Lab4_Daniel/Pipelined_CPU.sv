// 5 stage pipelined CPU
module Pipelined_CPU(reset, clk);
	input logic clk, reset;

	logic BrTaken;
	logic negative, zero, overflow, carry_out;
	logic [3:0] Flags;

	/*------------------------------------------- Stage 1 - IF -----------------------------------*/ 

	logic [63:0] branch_sum;
	logic [63:0] instr_addr_IF, instr_addr_RF;
   	logic [31:0] instruction_IF, instruction_RF;

	// stage 1 instruction fetch 
	IF s1 (.clk, .reset, .branchVal(branch_sum), .BrTaken, .instruction(instruction_IF), .instr_addr(instr_addr_IF));
	// refister fors stage 1-2
	IF_RF_reg reg1 (.clk, .reset, .instr_addr_IF, .instruction_IF, .instr_addr_RF, .instruction_RF);

	/*------------------------------------------ Stage 2 - RF -----------------------------------*/

	logic [63:0] dataA_RF, dataB_RF, immVal_RF, shift_output_RF, dataA_EX, dataB_EX, immVal_EX, shift_output_EX;
	logic ALUSrc_RF, memWrite_E_RF, MemToReg_RF, regWrite_E_RF,mem_read_RF, setFlag_RF, shiftSel_RF, ALUSrc_EX, 
		memWrite_E_EX, MemToReg_EX, regWrite_E_EX, mem_read_EX, setFlag_EX, shiftSel_EX, regWrite_E_WB, forwardOpflags;
	logic [4:0] regWrite_RF, regWrite_EX, readRegB, regWrite_WB;
	logic [2:0] ALUOp_RF, ALUOp_EX;

	logic [63:0] ALU_out_EX, ALU_out_MEM;
	logic [63:0] writeBack_mem, WriteData_WB;
	logic [6:0] instr_31_to_25_EX, instr_31_to_25_RF;
	logic [1:0] fOp_A, fOp_B;
	// Initialize Register/dec stage  - several connections need to be made dataMem, 
	RF s2 (.clk, .instruction(instruction_RF), .instr_addr(instr_addr_RF), .dataMem(writeBack_mem), .ALUOut(ALU_out_EX),
		.writeData(WriteData_WB), .readA(dataA_RF), .readB(dataB_RF), .immVal(immVal_RF), .forwardOpA(fOp_A), .forwardOpB(fOp_B),
		.writeEnable(regWrite_E_WB), .ALUSrc(ALUSrc_RF), .ALUOp(ALUOp_RF), .memWrite_E(memWrite_E_RF), .MemToReg(MemToReg_RF),
		.regWrite_E(regWrite_E_RF), .sum_PCandImm(branch_sum), .BrTaken, .WriteRegister(regWrite_WB), .Rd(regWrite_RF),
		.mem_read(mem_read_RF), .setFlag(setFlag_RF), .shiftSel(shiftSel_RF), .shift_output(shift_output_RF),
		.negative(Flags[0]), .overflow(Flags[2]), .readRegB, .forwardNeg(negative), .forwardOver(overflow), .forwardOpflags);

	// pass instruction[31:25] to next register 
	assign instr_31_to_25_RF = instruction_RF[31:25];
	// register in between regfile and execute stage
	RF_EX_reg reg2 (.clk, .reset, .dataA_RF, .dataB_RF, .immVal_RF, .shift_output_RF, .ALUSrc_RF, .memWrite_E_RF, .MemToReg_RF, .regWrite_E_RF,
            .mem_read_RF, .setFlag_RF, .shiftSel_RF, .regWrite_RF, .ALUOp_RF, .instr_31_to_25_RF, .dataA_EX, .dataB_EX, .immVal_EX, .shift_output_EX,
            .ALUSrc_EX, .memWrite_E_EX, .MemToReg_EX, .regWrite_E_EX, .mem_read_EX, .setFlag_EX, .shiftSel_EX, .regWrite_EX, .ALUOp_EX, .instr_31_to_25_EX);

	/*----------------------------------------- Stage 3 - EX ------------------------------------------*/
	
    logic memWrite_E_MEM, MemToReg_MEM, regWrite_E_MEM, mem_read_MEM;
    logic [4:0] regWrite_MEM;
    logic [63:0] mem_Din_MEM;

	// execute stage
	EX s3 (.ALUSrc(ALUSrc_EX), .ALUOp(ALUOp_EX), .immVal(immVal_EX), 
		.dataA(dataA_EX), .dataB(dataB_EX), .execute_output(ALU_out_EX),
		.negative, .zero, .overflow, .carry_out, .shiftSel(shiftSel_EX), .shift_result(shift_output_EX));
	// register between stage 3 and 4
	EX_MEM_reg  reg3 (.clk, .reset, .memWrite_E_EX, .MemToReg_EX, .regWrite_E_EX, .mem_read_EX, .ALU_out_EX, 
			.regWrite_EX, .mem_Din_EX(dataB_EX), .memWrite_E_MEM, .MemToReg_MEM, .regWrite_E_MEM, .mem_read_MEM,
			.ALU_out_MEM, .regWrite_MEM, .mem_Din_MEM);
	
	/*------------------------------------- Stage 4 - MEM -------------------------------------------*/

	MEM s4 (.clk, .reset, .MemWrite(memWrite_E_MEM), .dataMem_in(mem_Din_MEM), .mem_addr(ALU_out_MEM),
			.writeBack(writeBack_mem), .mem_read(mem_read_MEM), .memToReg(MemToReg_MEM));
	// register between stage 4 and 5
	MEM_WB_reg  reg4 (.clk, .reset, .regWrite_E_MEM, .WriteData_MEM(writeBack_mem), .regWrite_MEM, 
			.regWrite_E_WB, .WriteData_WB, .regWrite_WB); 
	
	/*------------------------------------ Stage 5 - WB --------------------------------------------*/
	// used output of MEM_WB register as write data inputs to EX stage

	/*------------------------------------ forwarding unit -----------------------------------------*/
	// outputs opcode for 3:1 mux for forwarding data and opcode for 2:1 mux for forwarding flags. 
	forwarding_unit forwardUnit (.addr_A(instruction_RF[9:5]), .addr_B(readRegB), .write_reg_mem(regWrite_MEM),
			.regWrite_E_mem(regWrite_E_MEM), .write_reg_alu(regWrite_EX), .regWrite_E_alu(regWrite_E_EX),
			.forwardOp_A(fOp_A), .forwardOp_B(fOp_B), .instr_31_to_25_EX, .cur_instr_31_24(instruction_RF[31:24]), .forwardOpflags);
	// set flags 
	updateFlags flagSe (.setFlag(setFlag_EX), .Flags, .negative, .zero, .overflow, .carryOut(carry_out), .reset, .clk);
endmodule

`timescale 1ps/1ps
module Pipelined_CPU_testbench();
	logic clk, reset;
	
	parameter ClockDelay = 20000;

	 Pipelined_CPU dut (.*);

   initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1'b1; repeat(2)@(posedge clk);
		reset <= 1'b0; @(posedge clk);
		repeat(80)@(posedge clk);
		$stop;
	end
endmodule

