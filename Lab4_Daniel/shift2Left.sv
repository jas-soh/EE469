/*  shifts 64 bit value to the left by two. fills in the two LSB's with zeros 
    NOTE: Has not been tested. 
*/
module shift2Left (in, out);
    input logic [63:0] in;
    output logic [63:0] out;

    assign out[63:2] = in[61:0];
    assign out[1:0] = 2'd0;

endmodule