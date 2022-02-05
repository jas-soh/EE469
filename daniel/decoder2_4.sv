// Jasmine Soh, Daniel Leick

// This module is a 2 to 4 decoder
// Inputs:
//            in: 2-bit input
//            out: 4-bit output that represents which bit was selected by the input
`timescale 1ps/1ps
module decoder2_4 (i, d, enable);
	input logic [1:0] i;
	output logic [3:0] d;
	input logic enable;
	
	logic ni0, ni1;
	
	not #50 inv0 (ni0, i[0]);
	not #50 inv1 (ni1, i[1]);
	
	and #50 d3 (d[3], i[0], i[1], enable);
	and #50 d2 (d[2], ni0, i[1], enable);
	and #50 d1 (d[1], i[0], ni1, enable);
	and #50 d0 (d[0], ni0, ni1, enable);
	
endmodule

module decoder2_4_testbench();   
  logic [1:0] i;    
  logic [3:0] d;   
  logic enable;
  
  decoder2_4 dut (i, d, enable)  ; 
  
  initial begin   
		i <= 2'b00; enable <=0; #100;
		i <= 2'b00;					#100;
		i <= 2'b01;					#100;
		i <= 2'b10;					#100;
		i <= 2'b11;					#100;
		i <= 2'b00; enable <=1; #100;
		i <= 2'b00;					#100;
		i <= 2'b01;					#100;
		i <= 2'b10;					#100;
		i <= 2'b11;					#100;
		$stop;
  end   
endmodule 