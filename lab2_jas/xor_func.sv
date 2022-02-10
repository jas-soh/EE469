// This module calculates the xor logic of a 64-bit binary value.
// Inputs:
//      64-bit in: input binary value
// Outputs:
//      1-bit out: logic of xor for all bits
`timescale 1ps/1ps
module XOR_func (A, B, out);
    input logic [63:0] A, B;
    output logic [63:0] out;

    logic [63:0] AnotB, BnotA;
    logic [63:0] not_A, not_B;
    logic [63:0] and_out1, and_out2;
    genvar i;
    generate
        for (i = 0; i < 64; i++) begin : eachBit
            not #50 notgateA (not_A[i], A[i]);
            not #50 notgateB (not_B[i], B[i]);
            and #50 orgate1 (and_out1[i], A[i], not_B[i]);
            and #50 orgate2 (and_out2[i], not_A[i], B[i]);
            or #50 orgate3 (out[i], and_out1[i], and_out2[i]);
        end
    endgenerate 
endmodule

`timescale 1ns/1ns
module XOR_func_testbench ();
    logic [63:0] A,B;
    logic [63:0] out;

    XOR_func dut (.*);

    initial begin
        A = '1; B = '1; #10;
        assert (out == '0);

        A = '0; B = '0; #10;
        assert (out == '0);

        A = '1; B = '0; #10;
        assert (out == '1);

        A = '0; B = '1; #10;
        assert (out == '1);
    end
endmodule