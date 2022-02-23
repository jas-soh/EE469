// Input controls: MemWE, Mem2Reg, RegWE
// Controls passed on: RegWE
module MEM (clk, MemToReg_MEM, ALU_out_MEM, Db_MEM, MemWrite_MEM, read_enable_MEM, MemToReg_out_MEM);
    input logic clk;
    input logic [63:0] ALU_out_MEM, Db_MEM;
    input logic MemToReg_MEM; // control
    input logic MemWrite_MEM, read_enable_MEM;
    output logic MemToReg_out_MEM;

    logic [63:0] Dout;
    datamem data_memory (.address(ALU_out_MEM), .write_enable(MemWrite_MEM), .read_enable(read_enable_MEM),
        .write_data(Db_MEM), .clk, .xfer_size(4'd8), .read_data(Dout)); // todo xfer

    // choose alu output or data memory output
    mux2_1_multi #(64) MemToReg_mux (.s0(MemToReg_MEM), .a(ALU_out_MEM), .b(Dout), .out(MemToReg_out_MEM)); 

endmodule

`timescale 1ps/1ps
module MEM_testbench ();
    parameter ClockDelay = 5000;

    // inputs
    logic clk;
    logic MemToReg_MEM;
    logic [63:0] ALU_out_MEM, Db_MEM;
    logic MemWrite_MEM, read_enable_MEM;

    // outputs
    logic MemToReg_out_MEM;

    MEM dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        MemToReg_MEM = 0;
        ALU_out_MEM = '0; Db_MEM = '0; read_enable_MEM = 1;
        MemWrite_MEM = 1;
        repeat(5) @(posedge clk);

        MemToReg_MEM = 1;
        ALU_out_MEM = '0; Db_MEM = '0; read_enable_MEM = 1;
        MemWrite_MEM = 0;
        repeat(5) @(posedge clk);
        $stop;
    end

endmodule