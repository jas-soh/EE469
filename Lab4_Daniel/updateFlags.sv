
module updateFlags(setFlag, Flags, negative, zero, overflow, carryOut, reset, clk);
	input logic setFlag, negative, zero, overflow, carryOut,
					reset, clk;
	output logic [3:0] Flags;
	
	logic negSel, zeroSel, overSel, cOutSel;
	
	mux2_1 selectorNeg (.s0(setFlag), .a(Flags[0]), .b(negative), .out(negSel));
	D_FF neg (.q(Flags[0]), .d(negSel), .reset, .clk);
	
	mux2_1 selectorZero (.s0(setFlag), .a(Flags[1]), .b(zero), .out(zeroSel));
	D_FF zer (.q(Flags[1]), .d(zeroSel), .reset, .clk);
	
	mux2_1 selectorOverFl (.s0(setFlag), .a(Flags[2]), .b(overflow), .out(overSel));
	D_FF ove (.q(Flags[2]), .d(overSel), .reset, .clk);
	
	mux2_1 selectorCOut (.s0(setFlag), .a(Flags[3]), .b(carryOut), .out(cOutSel));
	D_FF cOu (.q(Flags[3]), .d(cOutSel), .reset, .clk);
	
	
	
endmodule