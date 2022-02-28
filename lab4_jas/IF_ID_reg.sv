// This module is the pipeline register between instruction fetch and instruction decode stages
module IF_ID_reg (clk, reset, instr, instr_addr, instr_ID, instr_addr_ID);
    input logic clk, reset;
    input logic [31:0] instr;
    input logic [63:0] instr_addr;
    output logic [31:0] instr_ID;
    output logic [63:0] instr_addr_ID;

    //D_FF_var #(32) instr_dff (.q(instr_ID), .d(instr), .reset, .clk);
    D_FF_var #(64) addr_dff (.q(instr_addr_ID), .d(instr_addr), .reset, .clk);
    D_FF_var #(32) instr_dff (.q(instr_ID), .d(instr), .reset, .clk);
endmodule

`timescale 1ps/1ps
module IF_ID_reg_testbench();
    parameter ClockDelay = 5000;
    logic clk, reset;
    logic [31:0] instr;
    logic [63:0] instr_addr;
    logic [31:0] instr_ID;
    logic [63:0] instr_addr_ID;

    IF_ID dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        reset <= 1; repeat(5) @(posedge clk);
        reset <= 0; repeat(5) @(posedge clk);
        instr = 32'b10010001000000000010111111100100;
        instr_addr = '0; repeat(10) @(posedge clk);
    end
endmodule