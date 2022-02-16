// This module handles the logic for raising flags based on the output from the ALU.
// Inputs:
//      64-bit out_result: the output from the ALU
//      2-bit carries: the carry out signals from the addition/subtraction operation
// Outputs:
//      1-bit negative, zero, overflow, carry_out: flags

`timescale 1ps/1ps
module flags (out_result, carries, negative, zero, overflow, carry_out);
    input logic [63:0] out_result;
    input logic [1:0] carries;
    output logic negative, zero, overflow, carry_out;
	
    assign negative = out_result[63];
    nor64 zero_flag (.in(out_result), .out(zero));

    //logic overflow_inv;
    //assign overflow = carries[1] ^ carries[0];
    xor #50 overflow_flag (overflow, carries[1], carries[0]);
    //not #50 ov_notgate (overflow, overflow_inv);
    assign carry_out = carries[1];

endmodule

`timescale 1ns/1ns
module flags_testbench ();
    logic [63:0] out_result;
    logic [1:0] carries;
    logic negative, zero, overflow, carry_out;

    flags dut (.*);
    
    initial begin
        out_result = '0; carries = 2'b01; #10;
        assert (negative == 0 && zero == 1 && overflow == 1 && carry_out == 0);

        out_result = '1; carries = 2'b00; #10;
        assert (negative == 1 && zero == 0 && overflow == 0 && carry_out == 0);

        out_result = 64'b01; carries = 2'b11; #10;
        assert (zero == 0 && overflow == 0 && carry_out == 1);
    end
endmodule