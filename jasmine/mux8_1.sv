// This module selects amongst the 8 inputs to output only 1
// Inputs:
//			d: 8-bit data
//			sel: 1-bit to select which input
// Outputs:
// 		out: one bit from the input data bits

module mux8_1 (out, d, sel);
	input logic [7:0] d;
	input logic [2:0] sel;
	output logic out;
	
	logic mux0_out, mux1_out;

	mux4_1 mux0 (.s(sel[1:0]), .ins(d[3:0]), .out(mux0_out));
	mux4_1 mux1 (.s(sel[1:0]), .ins(d[7:4]), .out(mux1_out));
	mux2_1 mux2 (.s0(sel[2]), .a(mux0_out), .b(mux1_out), .out);
	
endmodule 