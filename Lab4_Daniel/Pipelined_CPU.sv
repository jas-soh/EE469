// todo, create pipelined cpu
module Pipelined_CPU(reset, clk);
	input logic clk, reset;

	logic BrTaken;
	logic negative, zero, overflow, carry_out;
	logic [3:0] Flags;
	logic [63:0] ALUOut;

	/*------------------------------------------- Stage 1 - IF -----------------------------------*/ 

	logic [63:0] branch_sum;
	logic [63:0] instr_addr_IF, instr_addr_RF;
   	logic [31:0] instruction_IF, instruction_RF;

	IF s1 (.clk, .reset, .branchVal(branch_sum), .BrTaken, .instruction(instruction_IF), .instr_addr(instr_addr_IF));
	// refister fors stage 1-2
	IF_RF_reg reg1 (.clk, .reset, .instr_addr_IF, .instruction_IF, .instr_addr_RF, .instruction_RF);

	/*------------------------------------------ Stage 2 - RF -----------------------------------*/

	logic [63:0] dataA_RF, dataB_RF, immVal_RF, shift_output_RF, dataA_EX, dataB_EX, immVal_EX, shift_output_EX;
	logic ALUSrc_RF, memWrite_E_RF, MemToReg_RF, regWrite_E_RF,mem_read_RF, setFlag_RF, shiftSel_RF, ALUSrc_EX, 
		memWrite_E_EX, MemToReg_EX, regWrite_E_EX, mem_read_EX, setFlag_EX, shiftSel_EX;
	logic [4:0] regWrite_RF, regWrite_EX;
	logic [2:0] ALUOp_RF, ALUOp_EX;

	// Initialize Register/dec stage  - several connections need to be made dataMem, 
	RF s2 (.clk, .instruction(instruction_RF), .instr_addr(instr_addr_RF), .dataMem(writeBack_mem), .ALUOut,
		.writeData(data_write), .readA(dataA_RF), .readB(dataB_RF), .immVal(immVal_RF), .forwardOpA(TODO), .forwardOpB(TODO),
		.writeEnable(regWrite_E_WB), .ALUSrc(ALUSrc_RF), .ALUOp(ALUOp_RF), .memWrite_E(memWrite_E_RF), .Mem2Reg(MemToReg_RF),
		.regWrite_E(regWrite_E_RF), .sum_PCandImm(branch_sum), .BrTaken, .WriteRegister(regWrite_WB), .Rd(regWrite_RF),
		.mem_read(mem_read_RF), .setFlag(setFlag_RF), .shiftSel(shiftSel_RF), .shift_output(shift_output_RF),
		.negative(Flags[0]), .overflow(Flags[2]));
	
	RF_EX_reg reg2 (.clk, .reset, .dataA_RF, .dataB_RF, .immVal_RF, .shift_output_RF, .ALUSrc_RF, .memWrite_E_RF, .MemToReg_RF, .regWrite_E_RF,
            .mem_read_RF, .setFlag_RF, .shiftSel_RF, .regWrite_RF, .ALUOp_RF, .dataA_EX, .dataB_EX, .immVal_EX, .shift_output_EX,
            .ALUSrc_EX, .memWrite_E_EX, .MemToReg_EX, .regWrite_E_EX, .mem_read_EX, .setFlag_EX, .shiftSel_EX, .regWrite_EX, .ALUOp_EX);

	/*----------------------------------------- Stage 3 - EX ------------------------------------------*/
	
    logic memWrite_E_MEM, MemToReg_MEM, regWrite_E_MEM, mem_read_MEM, shiftSel_MEM;
	logic [63:0] ALU_out_EX, ALU_out_MEM, shift_output_MEM;
    logic [4:0] regWrite_MEM;
    logic [63:0] mem_Din_MEM;

	// execute stage
	EX s3 (.ALUSrc(ALUSrc_EX), .ALUOp(ALUOp_EX), .immVal(immVal_EX), 
		.dataA(dataA_EX), .dataB(dataB_EX), .ALUSum(ALU_out_EX),
		.negative, .zero, .overflow, .carry_out);

	EX_MEM_reg  reg3 (.clk, .reset, .memWrite_E_EX, .MemToReg_EX, .regWrite_E_EX, .mem_read_EX, .ALU_out_EX, 
			.regWrite_EX, .mem_Din_EX(dataB_EX), .shift_output_EX, .shiftSel_EX, .memWrite_E_MEM, .MemToReg_MEM, 
			.regWrite_E_MEM, .mem_read_MEM, .ALU_out_MEM, .regWrite_MEM, .mem_Din_MEM, .shift_output_MEM, .shiftSel_MEM);
	
	/*------------------------------------- Stage 4 - MEM -------------------------------------------*/
	logic [63:0] writeBack_mem, WriteData_WB, shift_output_WB;
	logic regWrite_WB, shiftsel_WB, regWrite_E_WB;

	MEM s4 (.clk, .reset, .MemWrite(memWrite_E_MEM), .dataMem_in(mem_Din_MEM), .mem_addr(ALU_out_MEM),
			.writeBack(writeBack_mem), .mem_read(mem_read_MEM), .memToReg(MemToReg_MEMv));

	MEM_WB_reg  reg4 (.clk, .reset, .regWrite_E_MEM, .WriteData_MEM(writeBack), .regWrite_MEM, .shiftsel_MEM, 
			shift_output_MEM, .regWrite_E_WB, .WriteData_WB, regWrite_WB, shiftsel_WB, shift_output_WB); 
	
	/*------------------------------------ Stage 5 - WB --------------------------------------------*/
	logic [63:0] data_write;
	WB s5 (.mem_alu_out(WriteData_WB), .shift_output(shift_output_WB), .shift_sel(shiftsel_WB), .data_write);


	// Initialize forwarding unit - TODO 

	// set flags 
	updateFlags flagSe (.setFlag(setFlag_EX), .Flags, .negative, .zero, .overflow, .carryOut(carry_out), .reset, .clk);
endmodule


`timescale 1ps/1ps
module Pipelined_CPU_testbench();
	logic clk, reset;
	
	parameter ClockDelay = 10000;

	 Pipelined_CPU dut (.*);

   initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1'b1; repeat(2)@(posedge clk);
		reset <= 1'b0; @(posedge clk);
		repeat(12)@(posedge clk);
		$stop;
	end
endmodule

