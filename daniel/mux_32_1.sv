// Daniel Leick, Jasmine Soh

// This module selects amongst the 32 inputs to output only 1
// Inputs:
//            d: 32-bit data
//            sel: 1-bit to select which input
// Outputs:
//         out: one bit from the input data bits
`timescale 1ps/1ps
module mux_32_1 (inputs, out, readReg);
	input logic [31:0] inputs; 
	input logic [4:0] readReg;
	output logic out;
	
	logic [7:0] stage1;
	logic [1:0] stage2;
	// 8 4:1 muxes that will take in 32 inputs
	genvar i;
	generate
		for (i = 0; i < 8; i++) begin : building_mux
			mux4_1 inputs (.s(readReg[1:0]), .ins(inputs[i*4+3:i*4]), .out(stage1[i]));
		end
	endgenerate
	
	// two 4:1 muxes that control which of the 8 will be 'on'
	mux4_1 control1 (.s(readReg[3:2]), .ins(stage1[3:0]), .out(stage2[0]));
	mux4_1 control2 (.s(readReg[3:2]), .ins(stage1[7:4]), .out(stage2[1]));
	// one 2:1 mux to have the final ouput
	Mux2_1 outStage (.s0(readReg[4]), .a(stage2[0]), .b(stage2[1]), .out);

endmodule

// This module selects amongst the 2 inputs to output only 1
// Inputs:
//            d0: 1-bit data
//            d1: 1-bit data
//            sel: 1-bit to select which input
// Outputs:
//         out: one of the selected input
module Mux2_1 (s0, a, b, out);

	input logic a, b, s0;
	output logic out;
	
	logic temp0, temp1, ns0;
	
	not #50 inv0 (ns0, s0); 
	
	and #50 a0 (temp0, a, ns0);
	and #50 b1 (temp1, b, s0);
	
	or #50 outp (out, temp0, temp1);
	
endmodule

// This module selects amongst the 4 inputs to output only 1
// Inputs:
//            d: 4-bit data
//            sel: 1-bit to select which input
// Outputs:
//         out: one bit from the input data bits
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

// teestbench for the 32:1 mux
module mux_32_1_testbench();
	logic [31:0] inputs; 
	logic [4:0] readReg;
	logic out;
	
	mux_32_1 dut(inputs, out, readReg);
	
	integer i;
	initial begin
		//
		inputs = 32'b0; readReg = 5'b11111; #1000;
		inputs = 32'b1;
		for (i = 0; i < 32; i++) begin
			inputs = inputs << 1; #1000;
		end
		#100;
		
		inputs = 32'b0; readReg = 5'b00011; #1000;
		inputs = 32'b1;
		for (i = 0; i < 32; i++) begin
			inputs = inputs << 1; #1000;
		end
		#100;
		$stop;
	end
	
endmodule