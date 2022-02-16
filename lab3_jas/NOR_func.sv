// This module calculates the nor logic of a 64-bit binary value.
// Inputs:
//      64-bit in: input binary value
// Outputs:
//      1-bit out: logic of nor for all bits
`timescale 1ps/1ps
module nor64 (in, out);
    input logic [63:0] in;
    output logic out; 

    logic or16_out1, or16_out2, or16_out3, or16_out4, orgate_out;
    or16 zero_flag1 (.in(in[63:48]), .out(or16_out1));
    or16 zero_flag2 (.in(in[47:32]), .out(or16_out2));
    or16 zero_flag3 (.in(in[31:16]), .out(or16_out3));
    or16 zero_flag4 (.in(in[15:0]), .out(or16_out4));

    or #50 orgate (orgate_out, or16_out1, or16_out2, or16_out3, or16_out4);
    not #50 notgate (out, orgate_out);
    
endmodule

`timescale 1ps/1ps
module or16 (in, out);
    input logic [15:0] in;
    output logic out;

    logic out1, out2, out3, out4;
    or #50 norgate1 (out1, in[15], in[14], in[13], in[12]);
    or #50 norgate2 (out2, in[11], in[10], in[9], in[8]);
    or #50 norgate3 (out3, in[7], in[6], in[5], in[4]);
    or #50 norgate4 (out4, in[3], in[2], in[1], in[0]);

    or #50 norgate5 (out, out1, out2, out3, out4);
endmodule