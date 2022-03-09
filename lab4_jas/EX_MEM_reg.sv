module EX_MEM_reg (clk, reset, MemWrite_EX, MemToReg_EX, RegWrite_EX, read_enable_EX, ALU_out_EX, WriteRegister_EX, Din_EX,
    MemWrite_MEM, MemToReg_MEM, RegWrite_MEM, read_enable_MEM, ALU_out_MEM, WriteRegister_MEM, Din_MEM);

    input logic clk, reset;
    input logic MemWrite_EX;
    input logic MemToReg_EX;
    input logic RegWrite_EX;
    input logic read_enable_EX;
    input logic [63:0] ALU_out_EX;
    input logic [4:0] WriteRegister_EX;
    input logic [63:0] Din_EX;

    output logic MemWrite_MEM;
    output logic MemToReg_MEM;
    output logic RegWrite_MEM;
    output logic read_enable_MEM;
    output logic [63:0] ALU_out_MEM;
    output logic [4:0] WriteRegister_MEM;
    output logic [63:0] Din_MEM;

    D_FF MemWrite_dff (.q(MemWrite_MEM), .d(MemWrite_EX), .reset, .clk);
    D_FF MemToReg_dff (.q(MemToReg_MEM), .d(MemToReg_EX), .reset, .clk);
    D_FF RegWrite_dff (.q(RegWrite_MEM), .d(RegWrite_EX), .reset, .clk);
    D_FF read_enable_dff (.q(read_enable_MEM), .d(read_enable_EX), .reset, .clk);

    D_FF_var #(64) ALU_out_dff (.q(ALU_out_MEM), .d(ALU_out_EX), .reset, .clk);
    D_FF_var #(5) WriteRegister_dff (.q(WriteRegister_MEM), .d(WriteRegister_EX), .reset, .clk);
    D_FF_var #(64) Din_dff (.q(Din_MEM), .d(Din_EX), .reset, .clk);

endmodule

`timescale 1ps/1ps
module EX_MEM_reg_testbench ();
    parameter ClockDelay = 5000;

    // inputs
    logic clk, reset;
    logic MemWrite_EX;
    logic MemToReg_EX;
    logic RegWrite_EX;
    logic [63:0] ALU_out_EX;
    logic [4:0] WriteRegister_EX;
    logic [63:0] Din_EX;

    // outputs
    logic MemWrite_MEM;
    logic MemToReg_MEM;
    logic RegWrite_MEM;
    logic [63:0] ALU_out_MEM;
    logic [4:0] WriteRegister_MEM;
    logic [63:0] Din_MEM;

    EX_MEM_reg dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        reset = 1; @(posedge clk);
        reset = 0; @(posedge clk);

        MemWrite_EX = 1;
        MemToReg_EX = 1;
        RegWrite_EX = 1;
        ALU_out_EX = '0;
        WriteRegister_EX = '0;
        Din_EX = '0; repeat(5) @(posedge clk);
        
        MemWrite_EX = 1;
        MemToReg_EX = 1;
        RegWrite_EX = 1;
        ALU_out_EX = '0;
        WriteRegister_EX = '0;
        Din_EX = '0; repeat(5) @(posedge clk);

        $stop;
    end 
endmodule