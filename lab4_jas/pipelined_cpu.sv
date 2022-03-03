module pipelined_cpu (reset, clk);
    input logic reset, clk;

    // output logic variables
    logic [63:0] instr_addr;
    logic [31:0] instr;
    logic [31:0] instr_ID;
    logic [63:0] instr_addr_ID;
    logic ALUSrc_ID, MemToReg_ID, RegWrite_ID, MemWrite_ID, BrTaken_ID; // control signals
    logic [2:0] ALUOp_ID;
    logic read_enable_ID, setFlag_ID;
    logic [63:0] ImmSize_out_ID;
    logic [63:0] Da_ID, Db_ID;
    logic [4:0] WriteRegister_ID;
    logic [63:0] branchVal;
    //logic branch;
    logic cntrl_ov, cntrl_neg;
    logic [4:0] Aa, Ab;
    logic ALUSrc_EX, MemToReg_EX, RegWrite_EX, MemWrite_EX;
    logic [31:0] instr_EX;
    logic [2:0] ALUOp_EX;
    logic [63:0] ImmSize_out_EX;
    logic [63:0] Da_EX, Db_EX;
    logic [63:0] ALU_out_EX;
    logic read_enable_EX, setFlag_EX;
    logic ALUzeroFlag, negFlag, ovFlag, carryFlag, zeroFlag;
    logic [63:0] Din_EX;
    logic [4:0] WriteRegister_EX;
    logic MemWrite_MEM;
    logic MemToReg_MEM;
    logic RegWrite_MEM;
    logic read_enable_MEM;
    logic [63:0] ALU_out_MEM;
    logic [4:0] WriteRegister_MEM;
    //logic [63:0] Din_MEM;
    //logic ALU_out_MEM, MemWrite_MEM, read_enable_MEM;
    logic [63:0] Din_MEM;
    logic [63:0] WriteData_MEM;
    logic RegWrite_WB;
    logic [63:0] WriteData_WB;
    logic [4:0] WriteRegister_WB;
    logic [1:0] forwardA, forwardB;
    logic accel_zero, accel_lt;
    logic ALU_ov, ALU_cout, ALU_neg;

    // ---------- Instruction fetch ----------
    // input logic clk, reset;
    // input logic BrTaken
    // input logic [63:0] branchVal;
    // output logic [63:0] instr_addr;
    // output logic [31:0] instr;
    // logic [63:0] instr_addr;
    // logic [31:0] instr;
    IF instruction_fetch (.clk, .reset, .instr_addr, .instr, .branchVal, .BrTaken(BrTaken_ID));

    // ---------- IF to ID reg ----------
    // input logic clk, reset;
    // input logic IF_instr;
    // input logic IF_instr_addr;
    // output logic [63:0] ID_instr;
    // output logic [63:0] ID_instr_addr;
    // logic [63:0] ID_instr;
    // logic [63:0] ID_instr_addr; 
    IF_ID_reg pipelined_IF_ID (.clk, .reset, .instr, .instr_addr, .instr_ID, .instr_addr_ID);

    // ---------- instruction decode ----------
    // input logic clk, reset;
    // input logic [31:0] instr;
    // input logic branch, ALUzeroFlag, RegWrite_WB;
    // input logic [4:0] WriteRegister_WB;
    // input logic [63:0] WriteData_WB;

    // output logic ALUSrc_ID, MemToReg_ID, RegWrite_ID, MemWrite_ID, BrTaken_ID;
    // output logic [2:0] ALUOp_ID;
    // output logic read_enable_ID;
    // output logic [63:0] ImmSize_out;
    // output logic [63:0] Da, Db;
    // output logic [4:0] WriteRegister_ID;
    // logic ALUSrc_ID, MemToReg_ID, RegWrite_ID, MemWrite_ID, BrTaken_ID; // control signals
    // logic [2:0] ALUOp_ID;
    // logic read_enable_ID;
    // logic [63:0] ImmSize_out_ID;
    // logic [63:0] Da_ID, Db_ID;
    // logic [63:0] branchVal;
    // logic [4:0] Aa, Ab;
    ID instruction_decode (.clk, .reset, .instr_ID, .instr_addr_ID, .ovFlag, .negFlag, .ALUzeroFlag, .ALU_neg, .ALU_ov, .WriteRegister_WB, .RegWrite_WB, .WriteData_WB,
        .ALUSrc_ID, .MemToReg_ID, .RegWrite_ID, .MemWrite_ID, .BrTaken_ID, .ALUOp_ID, .read_enable_ID, .setFlag_ID,
        .ImmSize_out_ID, .Da_ID, .Db_ID, .branchVal, .Rn(Aa), .Reg2Loc_out(Ab), .WriteRegister_ID,
        .WriteData_EX(ALU_out_EX), .WriteData_MEM, .forwardA, .forwardB, .accel_zero, .accel_lt);

    // forwarding unit
    forwarding_unit fwd (.Aa, .Ab, .RegWrite_MEM, .WriteRegister_MEM, .RegWrite_EX, .WriteRegister_EX, .forwardA, .forwardB);

    // accelerated branching
    accel_br accelerate (.instr_ID, .setFlag_EX, .Db_ID, .accel_zero, .accel_lt);

    // ---------- ID to EX reg ---------
    // input logic clk, reset;
    // input logic ALUSrc_ID, MemToReg_ID, RegWrite_ID, MemWrite_ID;
    // input logic [2:0] ALUOp_ID;
    // input logic ImmSize_out_ID;

    // output logic ALUSrc_EX, MemToReg_EX, RegWrite_EX, MemWrite_EX;
    // output logic [2:0] ALUOp_EX;
    // output logic ImmSize_out_EX;
    // logic ALUSrc_EX, MemToReg_EX, RegWrite_EX, MemWrite_EX;
    // logic [2:0] ALUOp_EX;
    // logic ImmSize_out_EX;
    // logic [63:0] Da_EX, Db_EX;
    ID_EX_reg pipelining_ID_EX (.clk, .reset, .instr_ID, .setFlag_ID, .ALUSrc_ID, .MemToReg_ID, .RegWrite_ID, .MemWrite_ID, .ALUOp_ID, .ImmSize_out_ID, .Da_ID, .Db_ID, .read_enable_ID, .WriteRegister_ID,
        .ALUSrc_EX, .instr_EX, .setFlag_EX, .MemToReg_EX, .RegWrite_EX, .MemWrite_EX, .ALUOp_EX, .ImmSize_out_EX, .Da_EX, .Db_EX, .read_enable_EX, .WriteRegister_EX);


    // ---------- execute ----------
    // input logic ALUSrc_EX;
    // input logic [2:0] ALUOp_EX;
    // input logic [63:0] Da_EX, Db_EX;
    // input logic [63:0] ImmSize_out_EX;

    // output logic [63:0] ALU_out_EX;
    // output logic ALUzeroFlag, negFlag, ovFlag;
    // logic [63:0] ALU_out_EX;
    // logic ALUzeroFlag, negFlag, ovFlag;
    // logic [63:0] Din_EX;

    EX execute (.reset, .ALUSrc_EX, .ALUOp_EX, .setFlag(setFlag_EX), .Da_EX, .Db_EX, .ImmSize_out_EX, .ALUzeroFlag, .ALU_neg, .ALU_ov, .ALU_cout, .ALU_out_EX, .Din_EX);

    updateFlag flags (.clk, .reset, .setFlag(setFlag_EX), .negative(ALU_neg), .zero(ALUzeroFlag), .overflow(ALU_ov), .carryOut(ALU_cout), .negFlag, .zeroFlag, .ovFlag, .carryFlag);
    // ---------- EX to MEM reg ----------
    // input logic clk, reset;
    // input logic MemWrite_EX;
    // input logic MemToReg_EX;
    // input logic RegWrite_EX;
    // input logic read_enable_EX;
    // input logic [63:0] ALU_out_EX;
    // input logic [4:0] WriteRegister_EX;
    // input logic [63:0] Din_EX;

    // output logic MemWrite_MEM;
    // output logic MemToReg_MEM;
    // output logic RegWrite_MEM;
    // input logic read_enable_MEM;
    // output logic [63:0] ALU_out_MEM;
    // output logic [4:0] WriteRegister_MEM;
    // output logic [63:0] Din_MEM;
    // logic MemWrite_MEM;
    // logic MemToReg_MEM;
    // logic RegWrite_MEM;
    // logic read_enable_MEM;
    // logic [63:0] ALU_out_MEM;
    // logic [4:0] WriteRegister_MEM;
    // logic [63:0] Din_MEM;
    EX_MEM_reg pipelining_EX_MEM (.clk, .reset, .MemWrite_EX, .MemToReg_EX, .RegWrite_EX, .read_enable_EX, .ALU_out_EX, .WriteRegister_EX, .Din_EX, 
        .MemWrite_MEM, .MemToReg_MEM, .RegWrite_MEM, .read_enable_MEM, .ALU_out_MEM, .WriteRegister_MEM, .Din_MEM);

    // ---------- memory fetch ----------
    // input logic clk;
    // input logic [63:0] ALU_out_MEM, Din_MEM;
    // input logic MemToReg_MEM; // control
    // input logic MemWrite_MEM, read_enable_MEM;
    // output logic [63:0] WriteData_MEM;
    // logic ALU_out_MEM, MemWrite_MEM, read_enable_MEM;
    // logic [63:0] MemToReg_out_MEM, Din_MEM;
    // logic [63:0] MemToReg_out_MEM;
    MEM memory_fetch (.clk, .MemToReg_MEM, .ALU_out_MEM, .Din_MEM, .MemWrite_MEM, .read_enable_MEM, .WriteData_MEM);

    // ---------- MEM to WB reg ----------
    // input logic clk, reset;
    // input logic RegWrite_MEM;
    // input logic [63:0] WriteData_MEM;
    // input logic [4:0] WriteRegister_MEM;

    // output logic RegWrite_WB;
    // output logic [63:0] WriteData_WB;
    // output logic [4:0] WriteRegister_WB;
    // logic RegWrite_WB;
    // logic [63:0] WriteData_WB;
    // logic [4:0] WriteRegister_WB;
    MEM_WB_reg pipelining_MEM_WB (.clk, .reset, .RegWrite_MEM, .WriteData_MEM, .WriteRegister_MEM, .RegWrite_WB, .WriteData_WB, .WriteRegister_WB);
endmodule

`timescale 1ps/1ps
module pipelined_cpu_testbench ();
    logic reset, clk;
    parameter ClockDelay = 20000;

    pipelined_cpu dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        reset <= 1; @(posedge clk);
        reset <= 0; repeat(50) @(posedge clk);
        $stop;
    end
endmodule