// This module is the execution stage.
// Controls passed on: MemWE, Mem2Reg, and RegWE.
module EX (reset, ALUSrc_EX, setFlag, ALUOp_EX, Da_EX, Db_EX, ImmSize_out_EX, 
    ALUzeroFlag, negFlag, ovFlag, ALU_out_EX, Din_EX, branch);

    input logic reset;
    input logic ALUSrc_EX, setFlag;
    input logic [2:0] ALUOp_EX;
    input logic [63:0] Da_EX, Db_EX;
    input logic [63:0] ImmSize_out_EX;

    output logic [63:0] ALU_out_EX;
    output logic ALUzeroFlag, negFlag, ovFlag;
    output logic [63:0] Din_EX;
    output logic branch;

    assign Din_EX = Db_EX;
    
    // choose Db or Imm
    logic [63:0] ALUSrc_out;
    mux2_1_multi #(64) ALUSrc_mux (.s0(ALUSrc_EX), .a(Db_EX), .b(ImmSize_out_EX), .out(ALUSrc_out));

    // ALU
    logic cOutFlag, zeroFlag;
    alu alu_operation (.A(Da_EX), .B(ALUSrc_out), .cntrl(ALUOp_EX), .result(ALU_out_EX),
        .negative(negFlag), .zero(ALUzeroFlag), .overflow(ovFlag), .carry_out_flag(cOutFlag));

    // input logic setFlag, reset;
    // input logic negFlag, ALUzeroFlag, ovFlag;
    // output logic branch, zeroFlag;
    updateFlag update (.reset, .setFlag, .negFlag, .ALUzeroFlag, .ovFlag, .branch, .zeroFlag);

endmodule

`timescale 1ps/1ps
module EX_testbench ();
    // inputs
    logic reset;
    logic ALUSrc_EX;
    logic [2:0] ALUOp_EX;
    logic [63:0] Da_EX, Db_EX;
    logic [63:0] ImmSize_out_EX;

    // output 
    logic [63:0] ALU_out_EX;
    logic ALUzeroFlag, negFlag, ovFlag;
    logic [63:0] Din_EX;
    logic branch;

    EX dut (.*);

    initial begin
        reset = 1; #5;
        reset = 0; #5;
        ALUSrc_EX = 1; ALUOp_EX = 3'b000; Da_EX = '0; Db_EX = '0; ImmSize_out_EX = '1; #50;
    end

endmodule 