//Daniel Leick
//Jasmine Soh

//Full Adder
//Inputs:
//	- a: 1 bit input to be added with b
//	- b: 1 bit input to be added with a
//	- cin: carry in to be added with a and b
//Outputs:
//	- s: ouput sum
//	- cOut: carry out result


`timescale 1ps/1ps
module fullAdder (a, b, cIn, s, cOut);
	input logic a, b, cIn;
	output logic cOut, s;
	
	logic t0, t1, t2;
	
	// Sum
	xor #50 sum (s, a, b, cIn);
	
	// Carry
	and #50 and0 (t0, a, cIn);
	and #50 and1 (t1, a, b);
	and #50 and2 (t2, b, cIn);
	or #50 C (cOut, t0, t1, t2);
 
 endmodule
 