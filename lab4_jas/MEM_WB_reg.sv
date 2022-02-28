// This module is the register between the MEM and WB stage.
// Inputs:
//      1-bit clk, reset
//      1-bit RegWrite_MEM: control signal passed
//      64-bit WriteData_MEM: data output from MemToReg mux
//      5-bit WriteRegister_MEM: register the data will be written to
// Outputs:
//      1-bit RegWrite_WB: control signal received
//      64-bit WriteData_WB: data output from MemToReg mux
//      5-bit WriteRegister_WB: register the data will be written to    
module MEM_WB_reg (clk, reset, RegWrite_MEM, WriteData_MEM, WriteRegister_MEM, RegWrite_WB, WriteData_WB, WriteRegister_WB);
    input logic clk, reset;
    input logic RegWrite_MEM;
    input logic [63:0] WriteData_MEM;
    input logic [4:0] WriteRegister_MEM;

    output logic RegWrite_WB;
    output logic [63:0] WriteData_WB;
    output logic [4:0] WriteRegister_WB;

    D_FF RegWrite_dff (.q(RegWrite_WB), .d(RegWrite_MEM), .reset, .clk);
    D_FF_var #(64) WriteData_dff (.q(WriteData_WB), .d(WriteData_MEM), .reset, .clk);
    D_FF_var #(5) WriteRegister_dff (.q(WriteRegister_WB), .d(WriteRegister_MEM), .reset, .clk);
    
endmodule

`timescale 1ps/1ps
module MEM_WB_reg_testbench();
    logic clk, reset;
    logic RegWrite_MEM;
    logic [63:0] WriteData_MEM;
    logic [4:0] WriteRegister_MEM;

    logic RegWrite_WB;
    logic [63:0] WriteData_WB;
    logic [4:0] WriteRegister_WB;

    parameter ClockDelay = 5000;

    MEM_WB_reg dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        reset = 1; @(posedge clk);
        reset = 0; @(posedge clk);

        RegWrite_MEM = 1; WriteData_MEM = '0; WriteRegister_MEM = '0; repeat(5) @(posedge clk);
        assert (RegWrite_WB == 1 && WriteData_MEM == '0 && WriteRegister_MEM == '0);

        RegWrite_MEM = 0; WriteData_MEM = '1; WriteRegister_MEM = '1; repeat(5) @(posedge clk);
        assert (RegWrite_WB == 0 && WriteData_MEM == '1 && WriteRegister_MEM == '1);

        $stop;
    end
endmodule