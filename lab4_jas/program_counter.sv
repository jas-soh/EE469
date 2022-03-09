// This module is the datapath for the program counter. It is controlled by the muxes
// and the control signals going into the muxes.
// Inputs:
//		1-bit UncondBr: control signal for mux to choose between conditional or unconditional branch
//		1-bit BrTaken: control signal for mux to branch or not
//		1-bit clk: clock signal
//		1-bit reset: reset signal
// Outputs:
//		64-bit instr_addr: instruction address that will be updated on the next cycle

module program_counter (instruction, instr_addr, UncondBr, BrTaken, clk, reset);
	output logic [31:0] instruction;
	output logic [63:0] instr_addr;
	input logic UncondBr, BrTaken; // control inputs
	input logic clk, reset;
	
	// calculating PC+4
	logic [63:0] PC4;
	assign PC4 = instr_addr + 4; // fix
	
	
	// sign extend condAddr19 and BrAddr26 then shift left by 2
	logic [63:0] SE_condAddr19, SE_BrAddr26;
	assign SE_BrAddr26 = {{38{instruction[25]}}, instruction[25:0]} << 2;
	assign SE_condAddr19 = {{45{instruction[23]}}, instruction[23:5]} << 2;
	
	// 2:1 Mux to choose condAddr or BrAddr based on UncondBr control signal
	logic [63:0] addr;
	mux2_1_multi #(64) UncondBr_mux (.s0(UncondBr), .a(SE_condAddr19), .b(SE_BrAddr26), .out(addr));
	
	// add PC and branch value 
	// PC + SE(Addr) << 2
	logic [63:0] sum_PCandImm, carry_PCandImm;
	adder64 PCandImm (.A(addr), .B(instr_addr), .subtract_signal(1'b0), .sum(sum_PCandImm), .carry_out(carry_PCandImm));
	
	// 2:1 Mux to choose between PC+4 and PC+addr
	logic [63:0] nextPC;
	mux2_1_multi #(64) BrTaken_mux (.s0(BrTaken), .a(PC4), .b(sum_PCandImm), .out(nextPC));
	
	instructmem instr (.address(instr_addr), .instruction, .clk);

	D_FF64 flip_flop (.q(instr_addr), .d(nextPC), .reset, .clk);
	
endmodule
// EDITS MADE:
// - removed instruction address as an input
// - assumed that instruction address is not something that is used anywhese else,
//   can keep it within the module
// - added initialization of instructmem here. makes sense here and not in datapath
// - changed instruction from input logic to output logic. driven by instructmem

`timescale 1ps/1ps
module program_counter_testbench ();
	logic [31:0] instruction;
	logic UncondBr, BrTaken; // control inputs
	logic clk;
	logic [63:0] instr_addr;
	logic reset;
	parameter ClockDelay = 5000;

	program_counter dut (.*);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	//initial instr_addr <= '0;
	initial begin
		// addi
		reset <= 1; UncondBr <= 1'b0; BrTaken <= 1'b0; @(posedge clk);
		reset <= 1; UncondBr <= 1'b0; BrTaken <= 1'b0; @(posedge clk);
		reset <= 0; UncondBr <= 1'b0; BrTaken <= 1'b0; @(posedge clk);
		reset <= 0; UncondBr <= 1'b0; BrTaken <= 1'b0; @(posedge clk);
		$stop;
	end
endmodule