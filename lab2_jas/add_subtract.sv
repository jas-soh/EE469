// This module calculates the bitwise addition or subtraction of two input values.
// Inputs:
//      64-bit A,B: input binary values that will be added or subtracted together
//      1-bit subtract_signal: signal to indicate addition or subtraction
// Outputs:
//      63-bit sum: result of the addition or subtration
//      63-bit carry: the carry out after each bit-wise sum
module add_subtract (A, B, subtract_signal, sum, carry);
    input logic [63:0] A, B;
    input logic subtract_signal;
    output logic [63:0] sum, carry;
    //output logic [63:0] B_mux_out;

    // get the negative of B
    logic [63:0] not_B;
    genvar n;
    generate
        for (n = 0; n < 64; n++) begin : invertBit
            not notgate (not_B[n], B[n]);
        end
    endgenerate 

    // mux to use B or -B based on input subtract_signal
    logic [63:0] B_mux_out;
    genvar i;
    generate
        for (i = 0; i < 64; i++) begin : each_Bbit
            mux2_1 mux (.s0(subtract_signal), .a(B[i]), .b(~B[i]), .out(B_mux_out[i]));
        end
    endgenerate

    // hard code 0 or 1 into first carry in
    fullAdder addBit0 (.A_bit(A[0]), .B_bit(B_mux_out[0]), .C_in(subtract_signal), .sum(sum[0]), .carry(carry[0]));    
    genvar j;
    generate
        for (j = 1; j < 64; j++) begin : eachBit
            fullAdder addBit (.A_bit(A[j]), .B_bit(B_mux_out[j]), .C_in(carry[j-1]), .sum(sum[j]), .carry(carry[j]));
        end
    endgenerate

endmodule


`timescale 1ns/1ns
module add_subtract_testbench ();
    logic [63:0] A, B;
    logic subtract_signal;
    logic [63:0] sum, carry;

    add_subtract dut (.*);

    initial begin

	    // testing sum on one bit
        A = 64'b0; B = 64'b1; subtract_signal = 0; #5;
	    assert (sum == 1 && carry == 0);

        // testing sum for all bits
        A = {{32{1'b1}},{32{1'b0}}}; B = {{32{1'b0}},{32{1'b1}}}; subtract_signal = 0; #5;
        assert (sum == '1 && carry == 0);

        // testing 1 + 1
        A = 64'b1; B = 64'b1; subtract_signal = 0; #5;
        assert (sum == 64'b10 && carry == 1);

        // testing at most significant bit
        A = {1'b1,{63{1'b0}}}; B = {1'b1,{63{1'b0}}}; subtract_signal = 0; #5;
        assert (sum == 0 && carry == {1'b1,{63{1'b0}}}); #5;

        // testing 1 - 0
        A = 64'b1; B = 64'b0; subtract_signal = 1; #5;
        assert (sum == 1 && carry == '1);

        // testing 1 - 1
        A = 64'b1; B = 64'b1; subtract_signal = 1; #5;
        assert (sum == 0 && carry == '1);
    end
endmodule
