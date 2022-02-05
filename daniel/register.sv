// Daniel Leick, Jasmine Soh

// This module is a single register composed of 64 D flip flop
// Inputs:
//            Din: 64-bit data
//				  enable: enable read 
//            clk: 1-bit clock
// Outputs:
//				  Dout: 64 bit register data
module register (Din, Dout, enable, clk);

	input logic [63:0] Din;
	input logic enable, clk;
	output logic [63:0] Dout;
	
	logic [63:0] muxOut;
	genvar i;
	generate

		for(i = 0; i < 64; i = i + 1) begin : building_one_register
			Mux2_1 selector (.s0(enable), .a(Dout[i]), .b(Din[i]), .out(muxOut[i]));
			D_FF bits (.q(Dout[i]), .d(muxOut[i]), .reset(1'b0), .clk);
		end
		
	endgenerate

endmodule

// DFF given in lab specs
module D_FF (q, d, reset, clk);
  output reg q; 
  input d, reset, clk; 
 
  always_ff @(posedge clk) 
  if (reset) 
    q <= 0;  // On reset, set to 0 
  else 
    q <= d; // Otherwise out = d 
endmodule


//odule Mux2_1 (s0, a, b, out);
//
//	input logic a, b, s0;
//	output logic out;
//	
//	logic temp0, temp1, ns0;
//	
//	not #50 inv0 (ns0, s0); 
//	
//	and #50 a0 (temp0, a, ns0);
//	and #50 b1 (temp1, b, s0);
//	
//	or #50 outp (out, temp0, temp1);
//	
//endmodule