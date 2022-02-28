module IF (clk, reset, instr_addr, instr, branchVal, BrTaken, accel_zero);
    input logic clk, reset;
    input logic BrTaken, accel_zero;
    input logic [63:0] branchVal;
    output logic [63:0] instr_addr;
    output logic [31:0] instr;

    // calculating PC+4
	logic [63:0] PC4;
	assign PC4 = instr_addr + 4; // TODO: adder

    logic [63:0] next_instr_addr; 
    mux2_1_multi #(64) BrTaken_mux (.s0(BrTaken | accel_zero), .a(PC4), .b(branchVal), .out(next_instr_addr));

    instructmem fetch_instr (.address(instr_addr), .instruction(instr), .clk);

    D_FF64 flip_flop (.q(instr_addr), .d(next_instr_addr), .reset, .clk);

endmodule

`timescale 1ps/1ps
module IF_testbench ();
    parameter ClockDelay = 5000;

    // inputs
    logic clk, reset;
    logic BrTaken, accel_zero;
    logic [63:0] branchVal;

    // outputs
    logic [63:0] instr_addr;
    logic [31:0] instr;

    IF dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        reset <= 1; branchVal <= '0; BrTaken <= 0; repeat(5) @(posedge clk);
        reset <= 0; branchVal <= '0; BrTaken <= 0; repeat(5) @(posedge clk);
        branchVal <= '0; BrTaken <= 0; repeat(10) @(posedge clk);
        $stop;
    end

endmodule