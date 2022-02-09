// top level module for single cycle CPU
// contains program counter, control, and datapath

module singCycle_CPU (reset, clk);
	input logic reset, clk;
	logic [31:0] instruction;
	logic [2:0] ALUOp;
	logic Reg2Loc, RegWrite, ALUSrc, MemWrite, 
					MemToReg, immSize, shiftSel;
	logic zeroFlag;
	logic BrTaken, UncondBr;
	logic setFlag;
	logic negative, zero, overflow, carry_out;
	
	// Flags[0] = negative; Flags[1] = zero; FLags[2] = overflow; Flags[3] = carry_out;
	logic [3:0] Flags;
	
	dataPath intruction_execution (.instruction, .Reg2Loc, .RegWrite, 
											 .ALUSrc, .ALUOp, .MemWrite, .MemToReg,
											 .immSize, .shiftSel, .clk,
											 .negative, .zero, .overflow, .carry_out);
	
	control cntrl_CPU (.instr(instruction), .zeroFlag(zero), .Reg2Loc, .ALUSrc, .MemToReg, 
					.RegWrite, .MemWrite, .BrTaken, .UncondBr, .ALUOp, .setFlag, 
					.immSize, .shiftSel, .negative(Flags[0]), .overflow(Flags[2]));
	
	program_counter PC (.instruction, .UncondBr, .BrTaken, .clk, .reset);
	
	always_ff @(posedge clk) begin
		if (reset) begin
			Flags <= '0;
		end
		else if (setFlag) begin
			Flags[0] <= negative;
			Flags[1] <= zero;
			Flags[2] <= overflow;
			Flags[3] <= carry_out;
		end
	end
	
endmodule

`timescale 1ps/1ps
module singCycle_CPU_testbench();
	logic clk, reset;
	
	parameter ClockDelay = 40000;

	singCycle_CPU dut (.*);

   initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1'b1; repeat(2)@(posedge clk);
		reset <= 1'b0; @(posedge clk);
		repeat(20)@(posedge clk);
		$stop;
	end
endmodule

// TO DO: TEST dataPath
// update: 
// - branches are occuring properly, not sure if datapath is adding correclty. 