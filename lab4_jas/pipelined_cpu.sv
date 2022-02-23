module pipelined_cpu (reset, clk);
    input logic reset, clk;

    //IF instruction_fetch ();
    // IF_ID_reg pipelining_IF_ID ();

    // ID instruction_decode ();
    // ID_EX_reg pipelining_ID_EX ();

    // EX execute ();
    // EX_MEM_reg pipelining_EX_MEM ();

    logic ALU_out_MEM, MemWrite_MEM, read_enable_MEM;
    logic [63:0] MemToReg_out_MEM, Db_MEM;
    logic [63:0] MemToReg_out_MEM;
    MEM memory_fetch (.clk, .ALU_out_MEM, .Db_MEM, .MemWrite_MEM, .read_enable_MEM, .MemToReg_out_MEM);

    // MEM_WB_reg pipelining_MEM_WB ();
endmodule

`timescale 1ps/1ps
module pipelined_cpu_testbench ();
    logic reset, clk;
    parameter ClockDelay = 5000;

    pipelined_cpu dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        reset = 0; @(posedge clk);
    end
endmodule