`timescale 1ps/1ps
module OR_func (A, B, out);
    input logic [63:0] A, B;
    output logic [63:0] out;

    genvar i;
    generate
        for (i = 0; i < 64; i++) begin : eachBit
            or #50 (out[i], A[i], B[i]);
        end
    endgenerate 
endmodule


`timescale 1ns/1ns
module OR_func_testbench ();
    logic [63:0] A, B;
    logic [63:0] out;

    OR_func dut (.*);

    initial begin
        // testing all 1s
        A = '1; B = '1; #10
        assert (out == '1);

        // testing all 0s
        A = '0; B = '0; #10
        assert (out == '0);

        // testing mix
        A = {{32{1'b1}},{32{1'b0}}}; B = {{32{1'b0}},{32{1'b1}}}; #10
        assert (out == '1);

        // testing mix
        A = {{32{1'b1}},{32{1'b0}}}; B = {{32{1'b1}},{32{1'b1}}}; #10
        assert (out == '1);
    end
endmodule