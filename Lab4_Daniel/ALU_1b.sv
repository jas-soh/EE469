//Daniel Leick
//Jasmine Soh
//
//1 bit ALU that performs addition, subraction, 
//bitwise and, or, and xor
//Inputs:
//	- a: 1 bit input for ALU
//	- b: 1 bit input for ALU
//	- sel: 3 bit selector to choose operation
//	- cIn: 1 bit carry in input
//OutPuts:
//	- r: result from ALU
//	- cOut: carry out from the ALU

`timescale 1ps/1ps
module ALU_1b (a, b, sel, r, cOut, cIn);
	
	input logic [2:0] sel;
	input logic a, b, cIn;
	output logic r, cOut;
	logic t010, t100, t101, t110, notB, bControl;
	
	not #50 invb (notB, b);
	
	// 2:1 mux for subtraction control 
	mux2_1 sub0 (.s0(sel[0]), .a(b), .b(notB), .out(bControl));
	
	// Add A + (B or ~B)
	fullAdder ad (.a, .b(bControl), .cIn, .s(t010), .cOut);
	
	// Bitwise And 
	and #50 and0 (t100, a, b);
	
	// Bitwise or
	or #50 or0 (t101, a, b);
	
	// Bitwise xor
	xor #50 xor0 (t110, a, b);
	
	// 8:1 mux to control output based on sel
	mux8_1 control (.out(r), .d({1'b0, t110, t101, t100, t010, t010, 1'b0, b}), .sel);
	 
endmodule


module ALU_1b_testbench();
	logic [2:0] sel;
	logic a, b, cIn;
	logic r, cOut;
	
	ALU_1b dut (.a, .b, .sel, .r, .cOut, .cIn);
	
	integer i;
	initial begin
		//result = B
		sel = 3'b000; a = 1'b0; b = 1'b0; cIn = 1'b0; #1000
		for (i=0; i < 8; i++) begin
			{a, b, cIn} = i; #1000;
		end
		
		//result = A + B
		sel = 3'b010; a = 1'b0; b = 1'b0; cIn = 1'b0; #1000
		for (i=0; i < 8; i++) begin
			{a, b, cIn} = i; #1000;
		end		
		
		//result = A - B
		sel = 3'b011; a = 1'b0; b = 1'b0; cIn = 1'b0; #1000
		for (i=0; i < 8; i++) begin
			{a, b, cIn} = i; #1000;
		end
		
		//result = bitwise A & B
		sel = 3'b100; a = 1'b0; b = 1'b0; cIn = 1'b0; #1000
		for (i=0; i < 4; i++) begin
			{a, b} = i; #1000;
		end		
		
		//result = bitwise A | B
		sel = 3'b101; a = 1'b0; b = 1'b0; cIn = 1'b0; #1000
		for (i=0; i < 4; i++) begin
			{a, b} = i; #1000;
		end
		
		//result = bitwise A xor B
		sel = 3'b110; a = 1'b0; b = 1'b0; cIn = 1'b0; #1000
		for (i=0; i < 4; i++) begin
			{a, b} = i; #1000;
		end
		
		// test output for sel = 001
		sel = 3'b001; a = 1'b0; b = 1'b0; cIn = 1'b0; #1000
		for (i=0; i < 8; i++) begin
			{a, b, cIn} = i; #1000;
		end
		
		// test output for sel = 111
		sel = 3'b111; a = 1'b0; b = 1'b0; cIn = 1'b0; #1000
		for (i=0; i < 8; i++) begin
			{a, b, cIn} = i; #1000;
		end
		$stop;
	end
endmodule
