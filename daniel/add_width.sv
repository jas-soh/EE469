module add_width #(parameter WIDTH = 64) (A, B, cIn, s, cOut);
	input logic [WIDTH-1:0] A, B;
	input logic cIn;
	output logic [WIDTH-1:0] s;
	output logic cOut;
	
	logic [63:0] carries;
	fullAdder bit_0 (.a(A[0]), .b(B[0]), .cIn, .s(s[0]), .cOut(carries[0]));
	
	genvar i;
	generate
		for (i = 1; i < 63; i++) begin : addBit
			fullAdder bit_i (.a(A[i]), .b(B[i]), .cIn(carries[i-1]), .s(s[i]), .cOut(carries[i]));
		end
	endgenerate
	fullAdder bit_64 (.a(A[63]), .b(B[63]), .cIn(carries[62]), .s(s[63]), .cOut);
endmodule
