// This module is the reg decode stage.
// Controls passed on: ALUSrc, ALUOp, MemWE, Mem2Reg, and RegWE.
module ID (clk, reset, instr_ID, instr_addr_ID, ALUzeroFlag, ovFlag, negFlag, WriteRegister_WB, RegWrite_WB, WriteData_WB,
    ALUSrc_ID, MemToReg_ID, RegWrite_ID, MemWrite_ID, BrTaken_ID, ALUOp_ID, read_enable_ID, setFlag_ID,
    ImmSize_out_ID, Da_ID, Db_ID, branchVal, Rn, Reg2Loc_out, WriteRegister_ID,
    WriteData_EX, WriteData_MEM, forwardA, forwardB, accel_zero, accel_lt, ALU_neg, ALU_ov);
    // input logic clk, reset;
    input logic clk, reset;
    input logic [31:0] instr_ID;
    input logic [63:0] instr_addr_ID;
    input logic ALUzeroFlag, ovFlag, negFlag, ALU_neg, ALU_ov, RegWrite_WB;
    input logic [4:0] WriteRegister_WB;
    input logic [63:0] WriteData_WB;
    input logic [63:0] WriteData_EX;
    input logic [63:0] WriteData_MEM;
    //input logic RegWrite_EX, RegWrite_MEM;
    input logic [1:0] forwardA, forwardB;
    input logic accel_zero, accel_lt;


    output logic ALUSrc_ID, MemToReg_ID, RegWrite_ID, MemWrite_ID, BrTaken_ID;
    output logic [2:0] ALUOp_ID;
    output logic read_enable_ID, setFlag_ID;
    output logic [63:0] ImmSize_out_ID;
    output logic [63:0] Da_ID, Db_ID;
    output logic [63:0] branchVal;
    output logic [4:0] Rn, Reg2Loc_out;
    output logic [4:0] WriteRegister_ID;
    

    logic UncondBr;
    logic shiftSel, immSize;
    logic Reg2Loc;
    logic cntrl_neg, cntrl_ov;
    control main_control (.instr(instr_ID), .ALUzeroFlag(ALUzeroFlag | accel_zero), .overflow(cntrl_ov), .negative(cntrl_neg),
        .Reg2Loc, .ALUSrc(ALUSrc_ID), .MemToReg(MemToReg_ID), .RegWrite(RegWrite_ID), .MemWrite(MemWrite_ID), .BrTaken(BrTaken_ID), .UncondBr,
        .ALUOp(ALUOp_ID), .setFlag(setFlag_ID), .shiftSel, .immSize, .read_enable(read_enable_ID));

    // sign extend condAddr19 and BrAddr26 then shift left by 2
	logic [63:0] SE_condAddr19, SE_BrAddr26;
	assign SE_BrAddr26 = {{38{instr_ID[25]}}, instr_ID[25:0]} << 2; // todo shifter
	assign SE_condAddr19 = {{45{instr_ID[23]}}, instr_ID[23:5]} << 2;

    // 2:1 Mux to choose condAddr or BrAddr based on UncondBr control signal
	logic [63:0] addr;
	mux2_1_multi #(64) UncondBr_mux (.s0(UncondBr), .a(SE_condAddr19), .b(SE_BrAddr26), .out(addr));

    // add PC and branch value 
	// PC + SE(Addr) << 2
	logic [63:0] carry_PCandImm;
	adder64 PCandImm (.A(addr), .B(instr_addr_ID), .subtract_signal(1'b0), .sum(branchVal), .carry_out(carry_PCandImm));

    // SE(IMM9) and ZE(Imm12)
    logic [63:0] SE_Imm9;
    logic [63:0] ZE_Imm12;
    //logic [63:0] ImmSize_out_D;
    assign SE_Imm9 = {{55{instr_ID[20]}},instr_ID[20:12]};
    assign ZE_Imm12 = {{52{1'b0}},instr_ID[21:10]};
    mux2_1_multi #(64) ImmSize_mux (.s0(immSize), .a(SE_Imm9), .b(ZE_Imm12), .out(ImmSize_out_ID));

    // Register
    logic [4:0] Rd, Rm;
    //logic [63:0] Dw;
    logic [63:0] Da, Db;
    //logic [4:0] Reg2Loc_out;
    assign Rd = instr_ID[4:0];
    assign Rn = instr_ID[9:5];
    assign Rm = instr_ID[20:16];
    mux2_1_multi #(5) Reg2Loc_mux (.s0(Reg2Loc), .a(Rd), .b(Rm), .out(Reg2Loc_out));
    regfile register (.ReadData1(Da), .ReadData2(Db), .WriteData(WriteData_WB),
        .ReadRegister1(Rn), .ReadRegister2(Reg2Loc_out), .WriteRegister(WriteRegister_WB), .RegWrite(RegWrite_WB), .clk(~clk)); // todo not clk

    // forwarding data
    mux3_1_multi #(64) muxA (.s0(forwardA), .a(Da), .b(WriteData_MEM), .c(WriteData_EX), .out(Da_ID));
    mux3_1_multi #(64) muxB (.s0(forwardB), .a(Db), .b(WriteData_MEM), .c(WriteData_EX), .out(Db_ID));

    // forwarding flags
    mux2_1 mux_neg (.s0(accel_lt), .a(negFlag), .b(ALU_neg), .out(cntrl_neg));
    mux2_1 mux_ov (.s0(accel_lt), .a(ovFlag), .b(ALU_ov), .out(cntrl_ov));

    assign WriteRegister_ID = Rd;
    

endmodule

`timescale 1ps/1ps
module ID_testbench ();
    parameter ClockDelay = 5000;

    // inputs
    logic clk, reset;
    logic [31:0] instr_ID;
    logic [63:0] instr_addr_ID;
    logic ALUzeroFlag, ovFlag, negFlag, ALU_neg, ALU_ov, RegWrite_WB;
    logic [4:0] WriteRegister_WB;
    logic [63:0] WriteData_WB;
    logic [63:0] WriteData_EX;
    logic [63:0] WriteData_MEM;
    //logic [4:0] WriteRegister_EX;
    //logic [4:0] WriteRegister_MEM;
    //logic RegWrite_EX, RegWrite_MEM;
    logic [1:0] forwardA, forwardB;
    logic accel_zero, accel_lt;

    // outputs
    logic ALUSrc_ID, MemToReg_ID, RegWrite_ID, MemWrite_ID, BrTaken_ID;
    logic [2:0] ALUOp_ID;
    logic read_enable_ID;
    logic [63:0] ImmSize_out_ID;
    logic [63:0] Da_ID, Db_ID;
    logic [63:0] branchVal;
    logic [4:0] Rn, Reg2Loc_out;
    logic [4:0] WriteRegister_ID;

    ID dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        reset <= 1; @(posedge clk);
        reset <= 0; @(posedge clk);

        // instr_ID <= 32'b10010001000000000000001111100000;
        // branch <= 0; ALUzeroFlag <= 0; WriteRegister_WB <= '0; RegWrite_WB <= 1; WriteRegister_WB <= '0;
        // WriteData_EX <= '1; WriteData_MEM <= '1; RegWrite_EX <= '0; RegWrite_MEM <= 0; repeat(5) @(posedge clk);

        // instr_ID <= 32'b10010001000000000000001111100000;
        // branch <= 0; ALUzeroFlag <= 0; WriteRegister_WB <= '0; RegWrite_WB <= 0; WriteRegister_WB <= '0;
        // WriteRegister_EX <= '1; WriteRegister_MEM <= '1; RegWrite_EX <= 0; RegWrite_MEM <= 1; repeat(5) @(posedge clk);
        
        $stop;
    end
endmodule