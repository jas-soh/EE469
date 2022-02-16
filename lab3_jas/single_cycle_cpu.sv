// This module is the top-level for the single cycle cpu.
// Inputs:
//      1-bit clk: clcok
//      1-bit reset: reset signal
`timescale 1ps/1ps
module single_cycle_cpu (clk, reset);
	input logic clk, reset;
    parameter ClockDelay = 5000;

    // ---- control ----
    logic [31:0] instr;
    logic ALUzeroFlag, branch;
    logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, BrTaken, UncondBr;
    logic [2:0] ALUOp;
    logic setFlag, shiftSel, immSize, read_enable;
    control cntrl (.instr, .branch, .ALUzeroFlag, .Reg2Loc, .ALUSrc, .MemToReg, .RegWrite, .MemWrite, .BrTaken, .UncondBr, .ALUOp, .setFlag, .shiftSel, .immSize, .read_enable);
    
    // ---- program counter ----
    logic [63:0] instr_addr;
    program_counter pc (.instruction(instr), .instr_addr, .UncondBr, .BrTaken, .clk, .reset);

    // ---- datapath ----
    logic zeroFlag, negFlag, ovFlag;
    datapath dp (.instr, .Reg2Loc, .ALUSrc, .MemToReg, .RegWrite, .MemWrite, .ALUOp, .setFlag, .shiftSel, .immSize, .read_enable, .clk, .ALUzeroFlag, .negFlag, .ovFlag);

    updateFlag update (.reset, .setFlag, .negFlag, .ALUzeroFlag, .ovFlag, .branch, .zeroFlag);


endmodule

`timescale 1ps/1ps
module single_cycle_cpu_testbench ();
    logic clk, reset;
    parameter ClockDelay = 5000;

    single_cycle_cpu dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
    
    initial begin
        reset <= 1; repeat(5) @(posedge clk);
        reset <= 0; repeat(1200) @(posedge clk);
        $stop;
    end
endmodule