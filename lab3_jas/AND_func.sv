// This module calculates the and logic of a 64-bit binary value.
// Inputs:
//      64-bit in: input binary value
// Outputs:
//      1-bit out: logic of and for all bits
`timescale 1ps/1ps
module AND_func (A, B, out);
    input logic [63:0] A, B;
    output logic [63:0] out;

    genvar i;
    generate
        for (i = 0; i < 64; i++) begin : eachBit
            and #50 andgate (out[i], A[i], B[i]);
        end
    endgenerate 
endmodule


`timescale 1ns/1ns
module AND_func_testbench ();
    logic [63:0] A, B;
    logic [63:0] out;

    AND_func dut (.*);

    initial begin
        // testing all 1s
        A = '1; B = '1; #10;
        assert (out == '1);

        // testing all 0s
        A = '0; B = '0; #10;
        assert (out == '0);

        // testing mix
        A = {{32{1'b1}},{32{1'b0}}}; B = {{32{1'b0}},{32{1'b1}}}; #10;
        assert (out == '0);

        // testing mix {32{1'b1}}
        A = {{32{1'b1}},{32{1'b0}}}; B = {{32{1'b1}},{32{1'b1}}}; #10;
        assert (out == {{32{1'b1}},{32{1'b0}}});
    end
endmodule