module forwarding_unit (Aa, Ab, RegWrite_MEM, WriteRegister_MEM, RegWrite_EX, WriteRegister_EX, forwardA, forwardB);

    input logic [4:0] Aa, Ab;

    // from mem stage
    input logic RegWrite_MEM;
    input logic [4:0] WriteRegister_MEM;

    // from ex stage
    input logic RegWrite_EX;
    input logic [4:0] WriteRegister_EX;

    // control signals for muxes
    output logic [1:0] forwardA;
    output logic [1:0] forwardB; 

    always_comb begin
        if ((Aa != 5'b11111) && RegWrite_EX && (Aa == WriteRegister_EX)) forwardA = 2'b10; 
        else if ((Aa != 5'b11111) && RegWrite_MEM && (Aa == WriteRegister_MEM)) forwardA = 2'b01;
        else forwardA = 2'b0;
        
        if ((Ab != 5'b11111) && RegWrite_EX && (Ab == WriteRegister_EX)) forwardB = 2'b10; 
        else if ((Ab != 5'b11111) && RegWrite_MEM && (Ab == WriteRegister_MEM)) forwardB = 2'b01;
        else forwardB = 2'b0;
    end

endmodule

`timescale 1ps/1ps
module forwarding_unit_testbench ();
    logic [4:0] Aa, Ab;

    // from mem stage
    logic RegWrite_MEM;
    logic [4:0] WriteRegister_MEM;

    // from ex stage
    logic RegWrite_EX;
    logic [4:0] WriteRegister_EX;

    // output control signals for muxes
    logic [1:0] forwardA;
    logic [1:0] forwardB;

    forwarding_unit dut (.*);

    initial begin
        Aa = '0; Ab = '0; RegWrite_MEM = '0; WriteRegister_MEM = '0; RegWrite_EX ='0; WriteRegister_EX = '0; #30;
    end
endmodule