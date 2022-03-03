module ID_EX_reg (clk, reset, ALUSrc_ID, instr_ID, setFlag_ID, MemToReg_ID, RegWrite_ID, MemWrite_ID, ALUOp_ID, ImmSize_out_ID, Da_ID, Db_ID, read_enable_ID, WriteRegister_ID,
    ALUSrc_EX, instr_EX, setFlag_EX, MemToReg_EX, RegWrite_EX, MemWrite_EX, ALUOp_EX, ImmSize_out_EX, Da_EX, Db_EX, read_enable_EX, WriteRegister_EX);

    // alu alu_operation (.A(Da), .B(ALUSrc_out), .cntrl(ALUOp), .result(ALU_out),
    //     negative(negFlag), .zero(ALUzeroFlag), .overflow(ovFlag), .carry_out_flag(cOutFlag));

    // controls
    // BrTaken, UncondBr
    input logic clk, reset;
    input logic ALUSrc_ID, MemToReg_ID, RegWrite_ID, MemWrite_ID, read_enable_ID;
    input logic [2:0] ALUOp_ID;
    input logic [63:0]  ImmSize_out_ID;
    input logic [63:0] Da_ID, Db_ID;
    input logic [4:0] WriteRegister_ID;
    input logic [31:0] instr_ID;
    input logic setFlag_ID;

    output logic ALUSrc_EX, MemToReg_EX, RegWrite_EX, MemWrite_EX, read_enable_EX;
    output logic [2:0] ALUOp_EX;
    output logic [63:0] ImmSize_out_EX;
    output logic [63:0] Da_EX, Db_EX;
    output logic [4:0] WriteRegister_EX;
    output logic [31:0] instr_EX;
    output logic setFlag_EX;

    //D_FF Reg2Loc_dff (.q(Reg2Loc_EX), .d(Reg2Loc_ID), .reset, .clk);
    D_FF ALUSrc_dff (.q(ALUSrc_EX), .d(ALUSrc_ID), .reset, .clk);
    D_FF MemToReg_dff (.q(MemToReg_EX), .d(MemToReg_ID), .reset, .clk);
    D_FF RegWrite_dff (.q(RegWrite_EX), .d(RegWrite_ID), .reset, .clk);
    D_FF MemWrite_dff (.q(MemWrite_EX), .d(MemWrite_ID), .reset, .clk);
    D_FF read_enable_dff (.q(read_enable_EX), .d(read_enable_ID), .reset, .clk);
    D_FF setFlag_dff (.q(setFlag_EX), .d(setFlag_ID), .reset, .clk);

    D_FF_var #(3) ALUOp_dff (.q(ALUOp_EX), .d(ALUOp_ID), .reset, .clk);
    D_FF_var #(64) ImmSizeOut_dff (.q(ImmSize_out_EX), .d(ImmSize_out_ID), .reset, .clk);
    D_FF_var #(5) WriteRegister_dff (.q(WriteRegister_EX), .d(WriteRegister_ID), .reset, .clk);
    D_FF_var #(64) Da_dff (.q(Da_EX), .d(Da_ID), .reset, .clk);
    D_FF_var #(64) Db_dff (.q(Db_EX), .d(Db_ID), .reset, .clk);
    D_FF_var #(32) instr_dff (.q(instr_EX), .d(instr_ID), .reset, .clk);

endmodule

`timescale 1ps/1ps
module ID_EX_reg_testbench ();
    logic clk, reset;
    logic Reg2Loc_ID, ALUSrc_ID, MemToReg_ID, RegWrite_ID, MemWrite_ID, read_enable_ID;
    logic [2:0] ALUOp_ID;
    logic [63:0]  ImmSize_out_ID;
    logic [63:0] Da_ID, Db_ID;
    logic [4:0] WriteRegister_ID;
    logic [31:0] instr_ID;
    logic setFlag_ID;

    logic Reg2Loc_EX, ALUSrc_EX, MemToReg_EX, RegWrite_EX, MemWrite_EX, read_enable_EX;
    logic [2:0] ALUOp_EX;
    logic [63:0] ImmSize_out_EX;
    logic [63:0] Da_EX, Db_EX;
    logic [4:0] WriteRegister_EX;
    logic [31:0] instr_EX;
    logic setFlag_EX;

    parameter ClockDelay = 5000;

    ID_EX_reg dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        reset <= 1; @(posedge clk);
        reset <= 0; @(posedge clk);

        Reg2Loc_ID <= 0; instr_ID = '0; ALUSrc_ID <= 0; MemToReg_ID <= 0; RegWrite_ID <= 0; MemWrite_ID <= 0; Da_ID <= '0; Db_ID <= '0;
        ALUOp_ID <= '0; repeat(3) @(posedge clk);

        $stop;
    end

endmodule