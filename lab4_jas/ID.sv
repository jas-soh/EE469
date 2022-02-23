// This module is the reg decode stage.
// Controls passed on: ALUSrc, ALUOp, MemWE, Mem2Reg, and RegWE.
module ID (clk, reset, instr, branch, ALUzeroFlag);
    input logic clk, reset;
    input logic [31:0] instr;
    input logic branch, ALUzeroFlag;
    //input logic [63:0] EX_ALU_out, MEM_out;
    //input logic [1:0] forward_control;
    

    // // sign extend condAddr19 and BrAddr26 then shift left by 2
	// logic [63:0] SE_condAddr19, SE_BrAddr26;
	// assign SE_BrAddr26 = {{38{instr[25]}}, instr[25:0]} << 2;
	// assign SE_condAddr19 = {{45{instr[23]}}, instr[23:5]} << 2;

    // // 2:1 Mux to choose condAddr or BrAddr based on UncondBr control signal
	// logic [63:0] addr;
	// mux2_1_multi #(64) UncondBr_mux (.s0(UncondBr), .a(SE_condAddr19), .b(SE_BrAddr26), .out(addr));

    // // SE(IMM9) and ZE(Imm12)
    // logic [63:0] SE_Imm9;
    // logic [63:0] ZE_Imm12;
    // logic [63:0] ImmSize_out;
    // assign SE_Imm9 = {{55{instr[20]}},instr[20:12]};
    // assign ZE_Imm12 = {{52{1'b0}},instr[21:10]};

    // // 2:1 Mux to choose Rd or Rm
    // logic [4:0] Reg2Loc_out;
    // mux2_1_multi #(5) Reg2Loc_mux (.s0(Reg2Loc), .a(Rd), .b(Rm), .out(Reg2Loc_out));


    // // main control
    // logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, BrTaken, UncondBr;
    // logic [2:0] ALUOp;
    // logic setFlag, shiftSel, immSize, read_enable;
    // control main_control (.instr, .branch, .ALUzeroFlag,
    //     .Reg2Loc, .ALUSrc, .MemToReg, .RegWrite, .MemWrite, .BrTaken, .UncondBr,
    //     .ALUOp, .setFlag, .shiftSel, .immSize, .read_enable);

    // regfile register (.ReadData1(Da), .ReadData2(Db), .WriteData(Dw),
    //     .ReadRegister1(Rn), .ReadRegister2(Reg2Loc_out), .WriteRegister(Rd), .RegWrite, .clk(~clk));



endmodule