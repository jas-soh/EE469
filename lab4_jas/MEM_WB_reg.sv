module MEM_WB_reg (clk, reset, RegWrite_MEM, WriteData_MEM, WriteRegister_MEM, RegWrite_WB, WriteData_WB, WriteRegister_WB);
    input logic clk, reset;
    input logic RegWrite_MEM;
    input logic [63:0] WriteData_MEM;
    input logic [4:0] WriteRegister_MEM;

    output logic RegWrite_WB;
    output logic [63:0] WriteData_WB;
    output logic [4:0] WriteRegister_WB;

    // D_FF RegWrite_dff (.q(RegWrite_WB), .d(RegWrite_MEM), .reset, .clk);
    // D_FF_var #(64) WriteData_dff (.q(WriteData_WB), .d(WriteData_MEM), .reset, .clk);
    // D_FF_var #(5) WriteRegister_dff (.q(WriteRegister_WB), .d(WriteRegister_MEM), .reset, .clk);
    
endmodule

`timescale 1ps/1ps
module MEM_WB_reg_testbench();
    // logic clk, reset;
    // logic RegWrite_MEM;
    // logic [63:0] WriteData_MEM;
    // logic [4:0] WriteRegister_MEM;

    // logic RegWrite_WB;
    // logic [63:0] WriteData_WB;
    // logic [4:0] WriteRegister_WB;

    // parameter = 5000;

    // MEM_WB_reg dut (.*);

    // initial begin // Set up the clock
	// 	clk <= 0;
	// 	forever #(ClockDelay/2) clk <= ~clk;
	// end
endmodule