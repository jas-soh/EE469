//Daniel Leick
//Jasmine SOh
//
//64 bit ALU that performs addition, subtraction, 
//bitwise and, or, xor, and passB.
//outputs result as well as status flags for the operation

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

`timescale 1ps/1ps
module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	input logic		[63:0]	A, B;
	input logic		[2:0]		cntrl;
	output logic	[63:0]	result;
	output logic				negative, zero, overflow, carry_out;
	// wires that connect carryOuts to carryIns
	logic [62:0] cOut;
	
	// ALU for bit 0
	ALU_1b b0 (.a(A[0]), .b(B[0]), .sel(cntrl), .r(result[0]), .cOut(cOut[0]), .cIn(cntrl[0]));
	
	genvar i;
	generate
		for (i = 1; i < 63; i++) begin : ALU_bits
			ALU_1b b_i (.a(A[i]), .b(B[i]), .sel(cntrl), .r(result[i]), .cOut(cOut[i]), .cIn(cOut[i-1]));
		end
	endgenerate
	
	// ALU for bit 64 - Produces carry_out flag
	ALU_1b b_63 (.a(A[63]), .b(B[63]), .sel(cntrl), .r(result[63]), .cOut(carry_out), .cIn(cOut[62]));
	
	// ALU's created - produce flags
	// NEGATIVE FLAG
	assign negative = result[63];
	
	// OVERFLOW FLAG
	xor #50 overflow0 (overflow, carry_out,cOut[62]);
	
	logic [15:0] nors;
	generate
		for (i = 0; i < 16; i++) begin : nor_gates
			// hold whether 4 consecutive bits are zero
			nor #50 zer (nors[i], result[i*4], result[i*4+1], result[i*4+2], result[i*4+3]);
		end
	endgenerate
	
	logic [3:0] ands;
	generate
		for (i = 0; i < 4; i++) begin : and_gates
			and #50 and0 (ands[i], nors[i*4], nors[i*4+1], nors[i*4+2], nors[i*4+3]);
		end
	endgenerate
	
	// ZERO FLAG
	and #50 out (zero, ands[0], ands[1], ands[2], ands[3]);
endmodule

