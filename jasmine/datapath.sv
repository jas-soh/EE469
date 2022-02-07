module datapath (instr, Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, ALUOp, setFlag, shiftSel, immSize, clk, shamt, ALUzeroFlag, negFlag, ovFlag);
    input logic [31:0] instr;
    input logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite;
    input logic [2:0] ALUOp;
    input logic setFlag, shiftSel, immSize; // readmem;
    input logic clk;
    input logic [5:0] shamt;
    output logic ALUzeroFlag, negFlag, ovFlag;
    
    // Register
    logic [4:0] Rd, Rm, Rn;
    logic [63:0] Dw;
    logic [63:0] Da, Db;
    logic [4:0] Reg2Loc_out;
    assign Rd = instr[4:0];
    assign Rn = instr[9:5];
    assign Rm = instr[20:16];
    mux2_1_multi #(5) Reg2Loc_mux (.s0(Reg2Loc), .a(Rd), .b(Rm), .out(Reg2Loc_out));
    regfile register (.ReadData1(Da), .ReadData2(Db), .WriteData(Dw),
        .ReadRegister1(Rn), .ReadRegister2(Reg2Loc_out), .WriteRegister(Rd), .RegWrite, .clk(~clk));

    // choose SE(IMM9) or ZE(Imm12)
    logic [63:0] SE_Imm9;
    logic [63:0] ZE_Imm12;
    logic [63:0] ImmSize_out;
    assign SE_Imm9 = {{55{instr[20]}},instr[20:12]};
    assign ZE_Imm12 = {{52{1'b0}},instr[21:10]};
    mux2_1_multi #(64) ImmSize_mux (.s0(immSize), .a(SE_Imm9), .b(ZE_Imm12), .out(ImmSize_out));

    // choose Db or Imm
    logic [63:0] ALUSrc_out;
    mux2_1_multi #(64) ALUSrc_mux (.s0(ALUSrc), .a(Db), .b(ImmSize_out), .out(ALUSrc_out));

    // ALU
    logic [63:0] ALU_out;
    logic cOutFlag;
    alu alu_operation (.A(Da), .B(ALUSrc_out), .cntrl(ALUOp), .result(ALU_out),
        .negative(negFlag), .zero(ALUzeroFlag), .overflow(ovFlag), .carry_out_flag(cOutFlag));

    // data memory
    // input logic		[63:0]	address,
	// input logic					write_enable,
	// input logic					read_enable,
	// input logic		[63:0]	write_data,
	// input logic					clk,
	// input logic		[3:0]		xfer_size,
	// output logic	[63:0]	read_data
    logic [63:0] Dout;
    datamem data_memory (.address(ALU_out), .write_enable(MemWrite), .read_enable(1'b1),
        .write_data(ImmSize_out), .clk, .xfer_size(4'd8), .read_data(Dout)); // todo xfer

    // choose alu output or data memory output
    logic [63:0] MemToReg_out;
    mux2_1_multi #(64) MemToReg_mux (.s0(MemToReg), .a(ALU_out), .b(Dout), .out(MemToReg_out)); // TODO mux size

    // shift amount LSR
    logic [63:0] shift_out;
    shifter shift (.value(Da), .direction(1'b1), .distance(shamt), .result(shift_out));

    // choose shiftamount of mem for writing data to register
    mux2_1_multi #(64) shiftSel_mux (.s0(shiftSel), .a(shift_out), .b(MemToReg_out), .out(Dw));

endmodule

`timescale 1ps/1ps
module datapath_testbench ();
    logic [31:0] instr;
    logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite;
    logic [2:0] ALUOp;
    logic setFlag, shiftSel, immSize; // readmem;
    logic clk;
    logic [5:0] shamt;
    logic ALUzeroFlag, negFlag, ovFlag;
	parameter ClockDelay = 5000;

    datapath dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        // ADDI
		// ADDI Rd, Rn, Imm12: Reg[Rd] = Reg[Rn] + ZeroExtend(Imm12)
        instr = 32'b10010001000000000000001111100000;
        ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b100; setFlag = 0; 
        setFlag = 0; shiftSel = 0; immSize = 1; 
        shamt = 6'b0; @(posedge clk);

        instr = 32'b10010001000000000000010000000001;
        ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b100; setFlag = 0; 
        setFlag = 0; shiftSel = 0; immSize = 1; 
        shamt = 6'b0; @(posedge clk);

    $stop;
    end
endmodulemodule datapath (instr, Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, ALUOp, setFlag, shiftSel, immSize, clk, shamt, ALUzeroFlag, negFlag, ovFlag);
    input logic [31:0] instr;
    input logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite;
    input logic [2:0] ALUOp;
    input logic setFlag, shiftSel, immSize; // readmem;
    input logic clk;
    input logic [5:0] shamt;
    output logic ALUzeroFlag, negFlag, ovFlag;
    
    // Register
    logic [4:0] Rd, Rm, Rn;
    logic [63:0] Dw;
    logic [63:0] Da, Db;
    logic [4:0] Reg2Loc_out;
    assign Rd = instr[4:0];
    assign Rn = instr[9:5];
    assign Rm = instr[20:16];
    mux2_1_multi #(5) Reg2Loc_mux (.s0(Reg2Loc), .a(Rd), .b(Rm), .out(Reg2Loc_out));
    regfile register (.ReadData1(Da), .ReadData2(Db), .WriteData(Dw),
        .ReadRegister1(Rn), .ReadRegister2(Reg2Loc_out), .WriteRegister(Rd), .RegWrite, .clk(~clk));

    // choose SE(IMM9) or ZE(Imm12)
    logic [63:0] SE_Imm9;
    logic [63:0] ZE_Imm12;
    logic [63:0] ImmSize_out;
    assign SE_Imm9 = {{55{instr[20]}},instr[20:12]};
    assign ZE_Imm12 = {{52{1'b0}},instr[21:10]};
    mux2_1_multi #(64) ImmSize_mux (.s0(immSize), .a(SE_Imm9), .b(ZE_Imm12), .out(ImmSize_out));

    // choose Db or Imm
    logic [63:0] ALUSrc_out;
    mux2_1_multi #(64) ALUSrc_mux (.s0(ALUSrc), .a(Db), .b(ImmSize_out), .out(ALUSrc_out));

    // ALU
    logic [63:0] ALU_out;
    logic cOutFlag;
    alu alu_operation (.A(Da), .B(ALUSrc_out), .cntrl(ALUOp), .result(ALU_out),
        .negative(negFlag), .zero(ALUzeroFlag), .overflow(ovFlag), .carry_out_flag(cOutFlag));

    // data memory
    // input logic		[63:0]	address,
	// input logic					write_enable,
	// input logic					read_enable,
	// input logic		[63:0]	write_data,
	// input logic					clk,
	// input logic		[3:0]		xfer_size,
	// output logic	[63:0]	read_data
    logic [63:0] Dout;
    datamem data_memory (.address(ALU_out), .write_enable(MemWrite), .read_enable(1'b1),
        .write_data(ImmSize_out), .clk, .xfer_size(4'd8), .read_data(Dout)); // todo xfer

    // choose alu output or data memory output
    logic [63:0] MemToReg_out;
    mux2_1_multi #(64) MemToReg_mux (.s0(MemToReg), .a(ALU_out), .b(Dout), .out(MemToReg_out)); // TODO mux size

    // shift amount LSR
    logic [63:0] shift_out;
    shifter shift (.value(Da), .direction(1'b1), .distance(shamt), .result(shift_out));

    // choose shiftamount of mem for writing data to register
    mux2_1_multi #(64) shiftSel_mux (.s0(shiftSel), .a(shift_out), .b(MemToReg_out), .out(Dw));

endmodule

`timescale 1ps/1ps
module datapath_testbench ();
    logic [31:0] instr;
    logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite;
    logic [2:0] ALUOp;
    logic setFlag, shiftSel, immSize; // readmem;
    logic clk;
    logic [5:0] shamt;
    logic ALUzeroFlag, negFlag, ovFlag;
	parameter ClockDelay = 5000;

    datapath dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        // ADDI
		// ADDI Rd, Rn, Imm12: Reg[Rd] = Reg[Rn] + ZeroExtend(Imm12)
        instr = 32'b10010001000000000000001111100000;
        ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b100; setFlag = 0; 
        setFlag = 0; shiftSel = 0; immSize = 1; 
        shamt = 6'b0; @(posedge clk);

        instr = 32'b10010001000000000000010000000001;
        ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b100; setFlag = 0; 
        setFlag = 0; shiftSel = 0; immSize = 1; 
        shamt = 6'b0; @(posedge clk);

    $stop;
    end
endmodule
