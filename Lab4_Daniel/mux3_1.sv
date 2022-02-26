// 3:1 wide mux that is constructed from two 2:1 muxes. have not tested
`timescale 1ps/1ps
/*
 sel = 00 -> output A
 sel = 01 -> output B
 sel = 11 or 10 -> output C
 */
module mux3_1 #(parameter WIDTH = 64) (A, B, C, sel, OUT);
    input logic [WIDTH-1:0] A, B, C;
    input logic [1:0] sel;

    output logic [WIDTH-1:0] OUT;

    logic [63:0] temp;
    genvar i;
	generate
		for (i = 0; i < WIDTH; i++) begin : eachBit
			mux2_1  stge1 (.s0(sel[0]), .a(A[i]), .b(B[i]), .out(temp[i]));
            mux2_1  stge2 (.s0(sel[1]), .a(temp[i]), .b(C[i]), .out(OUT[i]));
		end
	endgenerate


endmodule