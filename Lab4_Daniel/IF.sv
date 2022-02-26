
// Instruction Fetch stage of the pipelined CPU
module IF(clk, reset, branchVal, BrTaken, instruction, instr_addr);
	input logic clk, reset, BrTaken;
	input logic [63:0] branchVal;
	
	output logic [31:0] instruction;
	output logic [63:0] instr_addr;
	
	logic [63:0] nextPC, add4;
	
	// 2:1 Mux to choose between PC+4 and PC+branchVal
	wide_mux2_1  BrTaken_mux (.s0(BrTaken), .A(add4), .B(branchVal), .OUT(nextPC));
	
	// register for program counter
	register PC (.Din(nextPC), .Dout(instr_addr), .enable(1'b1), .clk, .reset);
	
	// add PC + 4
	add_width addition4 (.A(instr_addr), .B(64'd4), .cIn(1'b0), .s(add4), .cOut());
	
	// instruction mem
	instructmem instr (.address(instr_addr), .instruction, .clk);
	
endmodule

`timescale 1ps/1ps
module IF_testbench();
	logic clk, reset, BrTaken;
	logic [63:0] branchVal;
	
	logic [31:0] instruction;
	logic [63:0] instr_addr;

	IF dut (.*);
	parameter ClockDelay = 10000;
   initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		reset <= 1'b1; branchVal <= '0; BrTaken <= 1'b0; repeat(2)@(posedge clk);
		reset <= 1'b0; @(posedge clk);
		repeat(20) @(posedge clk);
		$stop;
	end

endmodule
