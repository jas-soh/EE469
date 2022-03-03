// This module is the flag register that holds the flag values until a control updates it.
// Inputs:
//      1-bit setFlag: control to set the flag
//      1-bit reset: reset signal
// Outputs: 
//      1-bit branch: control for if the PC counter should branch
//      1-bit zeroFlag: zero flag

// module updateFlag (reset, setFlag, negFlag, ALUzeroFlag, ovFlag, branch, zeroFlag);
//     input logic reset, setFlag;
//     input logic negFlag, ALUzeroFlag, ovFlag;
//     output logic branch, zeroFlag;

//     always_comb begin
//         if (reset) begin
//             zeroFlag = 0;
//             branch = 0;
//         end
//         else if (setFlag) begin
//             zeroFlag = ALUzeroFlag;

//             if (negFlag != ovFlag) begin
//                 branch = 1;
//             end
//             else branch = 0;
//         end
    
//         else begin
//             zeroFlag = zeroFlag;
//             branch = branch;
//         end
//     end
// endmodule

// register that holds flags coming from ALU, 
// flags[0] - negative
// flags[1] - zero
// flags[2] - overflow
// flags[3] - carryout
module updateFlag(clk, reset, setFlag, negative, zero, overflow, carryOut, negFlag, zeroFlag, ovFlag, carryFlag);
//(.reset, .setFlag, .ALU_neg, .ALUzeroFlag, .ALU_ov, .negflag, .ovflag, .zeroFlag);
    // input logic reset, setFlag;
    // input logic negFlag, ALUzeroFlag, ovFlag;
    // output logic branch, zeroFlag;

	input logic setFlag, negative, zero, overflow, carryOut, reset, clk;
	output logic negFlag, zeroFlag, ovFlag, carryFlag;

    logic [3:0] Flags;
	logic negSel, zeroSel, overSel, cOutSel;
	
	mux2_1 selectorNeg (.s0(setFlag), .a(Flags[0]), .b(negative), .out(negSel));
	D_FF neg (.q(Flags[0]), .d(negSel), .reset, .clk);
	
	mux2_1 selectorZero (.s0(setFlag), .a(Flags[1]), .b(zero), .out(zeroSel));
	D_FF zer (.q(Flags[1]), .d(zeroSel), .reset, .clk);
	
	mux2_1 selectorOverFl (.s0(setFlag), .a(Flags[2]), .b(overflow), .out(overSel));
	D_FF ove (.q(Flags[2]), .d(overSel), .reset, .clk);
	
	mux2_1 selectorCOut (.s0(setFlag), .a(Flags[3]), .b(carryOut), .out(cOutSel));
	D_FF cOu (.q(Flags[3]), .d(cOutSel), .reset, .clk);

    assign negflag = Flags[0];
    assign zeroFlag = Flags[1];
    assign ovFlag = Flags[2];
    assign carryFlag = Flags[3];
	
endmodule

module updateFlag_testbench ();
    logic clk, setFlag, reset;
    logic negFlag, ALUzeroFlag, ovFlag;
    logic branch, zeroFlag;

    updateFlag dut (.*);

    initial begin
        // reset = 1; setFlag = 0; negFlag = 0; ALUzeroFlag = 0; ovFlag = 0; #10;
        
        // reset = 0; setFlag = 0; negFlag = 0; ALUzeroFlag = 0; ovFlag = 0; #10;
        // assert ((branch == 0) && (zeroFlag == 0));

        // reset = 0; setFlag = 1; negFlag = 0; ALUzeroFlag = 0; ovFlag = 0; #10;
        // assert ((branch == 0) && (zeroFlag == 0));

        // // test that nothing changes
        // reset = 0; setFlag = 0; negFlag = 0; ALUzeroFlag = 0; ovFlag = 0; #10;
        // assert ((branch == 0) && (zeroFlag == 0));

        // // test that branch changes to 1
        // reset = 0; setFlag = 1; negFlag = 1; ALUzeroFlag = 0; ovFlag = 0; #10;
        // assert ((branch == 1) && (zeroFlag == 0));

        // // change branch to 0 again
        // reset = 0; setFlag = 1; negFlag = 0; ALUzeroFlag = 0; ovFlag = 0; #10;
        // assert ((branch == 0) && (zeroFlag == 0));

        // // change branch to 1 again using other condition
        // reset = 0; setFlag = 1; negFlag = 0; ALUzeroFlag = 1; ovFlag = 0; #10;
        // assert ((branch == 1) && (zeroFlag == 1));
    end
endmodule