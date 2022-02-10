`timescale 1ps/1ps
module fullAdder (A_bit, B_bit, C_in, sum, carry);
    input logic A_bit, B_bit, C_in;
    output logic sum;
    output logic carry;

    logic xor1_out, and1_out, and2_out;

    xor xor1 (xor1_out, A_bit, B_bit);
    and and1 (and1_out, A_bit, B_bit);
    and and2 (and2_out, xor1_out, C_in);
    xor xor2 (sum, xor1_out, C_in);
    xor xor3 (carry, and2_out, and1_out);

endmodule

`timescale 1ps/1ps
module fullAdder_testbench ();
    logic A_bit, B_bit, C_in;
    logic sum, carry;

    fullAdder dut (.*);

    initial begin
        A_bit = 1; B_bit = 0; C_in = 1; #10;
        assert (sum == 0 && carry == 1);

        A_bit = 1; B_bit = 1; C_in = 0; #10;
        assert (sum == 0 && carry == 1);


        // for (int i = 0; i <= 1; i++) begin
        //     for (int j = 0; j <= 1; j++) begin
        //         for (int k = 0; k <= 1; k++) begin
        //             A_bit = i; B_bit = j; C_in = k; #10;
        //         end
        //     end
        // end
    end
endmodule