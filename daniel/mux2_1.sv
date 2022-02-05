
`timescale 1ps/1ps
module mux2_1 (s0, a, b, out);

	input logic a, b, s0;
	output logic out;
	
	logic temp0, temp1, ns0;
	
	not #50 inv0 (ns0, s0); 
	
	and #50 a0 (temp0, a, ns0);
	and #50 b1 (temp1, b, s0);
	
	or #50 outp (out, temp0, temp1);
	
endmodule