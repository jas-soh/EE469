
`timescale 1ps/1ps
module mux4_1 (s, ins, out);
	input logic [3:0] ins;
	input logic  [1:0] s;
	output logic out;
	
	logic temp0, temp1, temp2, temp3;
	logic ns0, ns1;
	
	not #50 inv0 (ns0, s[0]);
	not #50 inv1 (ns1, s[1]);
	
	and #50 a0 (temp0, ins[0], ns1, ns0);
	and #50 b1 (temp1, ins[1], ns1, s[0]);
	and #50 c2 (temp2, ins[2], s[1], ns0);
	and #50 d3 (temp3, ins[3], s[1], s[0]);
	
	or #50 outp (out, temp0, temp1, temp2, temp3);
	
endmodule