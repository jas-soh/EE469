// This module is the pipeline register between instruction fetch and instruction decode stages
module IF_ID_reg (clk, IF_instr, IF_instr_addr, ID_instr, ID_instr_addr);
    input logic clk, reset;
    input logic IF_instr;
    input logic IF_instr_addr;
    output logic [63:0] ID_instr;
    output logic [63:0] ID_instr_addr;

    D_FF_var #(64) if_id_dff (.q(ID_PC), .d(IF_PC), .reset, .clk);
endmodule

`timescale 1ps/1ps
module IF_ID_reg_testbench();
    parameter = 5000;
    logic clk, reset;
    logic IF_instr;
    logic IF_instr_addr;
    logic [63:0] ID_instr;
    logic [63:0] ID_instr_addr;

    IF_ID dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        IF_instr = 32'b10010001000000000010111111100100;
        IF_instr_addr = '0; @(posedge clk);
    end
endmodule