module datapath (instr, Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, ALUOp, setFlag, shiftSel, immSize, read_enable, clk, ALUzeroFlag, negFlag, ovFlag);
    input logic [31:0] instr;
    input logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite;
    input logic [2:0] ALUOp;
    input logic setFlag, shiftSel, immSize, read_enable; // readmem;
    input logic clk;
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
    datamem data_memory (.address(ALU_out), .write_enable(MemWrite), .read_enable,
        .write_data(Db), .clk, .xfer_size(4'd8), .read_data(Dout)); // todo xfer

    // choose alu output or data memory output
    logic [63:0] MemToReg_out;
    mux2_1_multi #(64) MemToReg_mux (.s0(MemToReg), .a(ALU_out), .b(Dout), .out(MemToReg_out)); 

    // shift amount LSR
    logic [63:0] shift_out;
    shifter shift (.value(Da), .direction(1'b1), .distance(instr[15:10]), .result(shift_out));

    // choose shiftamount of mem for writing data to register
    mux2_1_multi #(64) shiftSel_mux (.s0(shiftSel), .a(MemToReg_out), .b(shift_out), .out(Dw));

endmodule

`timescale 1ps/1ps
module datapath_testbench ();
    logic [31:0] instr;
    logic Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite;
    logic [2:0] ALUOp;
    logic setFlag, shiftSel, immSize, read_enable; // readmem;
    logic clk;
    logic ALUzeroFlag, negFlag, ovFlag;
	parameter ClockDelay = 10000;

    datapath dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        // ADDI
		// ADDI Rd, Rn, Imm12: Reg[Rd] = Reg[Rn] + ZeroExtend(Imm12)
        // 1001000100_000000000000_11111_00000 
        // instr = 32'b10010001000000000000001111100000; // X0 = 0
        // Reg2Loc = 0; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b010;
        // setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);
        

        // instr = 32'b10010001000000000000010000000001; // X1 = 1
        // Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b010;
        // setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // instr = 32'b10010001000000000000010000100010; // X2 = 2
        // Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b010;
        // setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // instr = 32'b10010001000000000000100000100011; // X3 = 3
        // Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b010;
        // setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // instr = 32'b10010001000000000001000000000100;    // ADDI X4, X0, #4      // X4 = 4
        // Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b010;
        // setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // instr = 32'b000101_00000000000000000000000000; // branch to zero
        // Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b010;
        // setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // ---------------------

        // instr = 32'b10010001000000000000011111100000;    // ADDI X0, X31, #1     // X0 =  1
        // Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b010;
        // setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // instr = 32'b11101011000000000000001111100001;   // SUBS X1, X31, X0     // X1 = -1
        // Reg2Loc = 1; ALUSrc = 1'b0; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b011;
        // setFlag = 1; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // instr = 32'b11101011000000010000000000000010;   // SUBS X2, X0, X1      // X2 =  2
        // Reg2Loc = 1; ALUSrc = 1'b0; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b011;
        // setFlag = 1; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // instr = 32'b11101011000000100000000000100011;   // SUBS X3, X1, X2      // X3 = -3
        // Reg2Loc = 1; ALUSrc = 1'b0; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b011;
        // setFlag = 1; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // instr = 32'b11101011000000010000000001100100;   // SUBS X4, X3, X1      // X4 = -2
        // Reg2Loc = 1; ALUSrc = 1'b0; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b011;
        // setFlag = 1; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // instr = 32'b10101011000_00100_000000_00011_00101;   // ADDS X5, X3, X4      // X5 = -5
        // Reg2Loc = 1'b1; ALUSrc = 1'b0; MemToReg = 1'b0;
		// RegWrite = 1'b1; MemWrite = 1'b0; ALUOp = 3'b010; 
        // setFlag = 1; shiftSel = 0; immSize = 1'bx; repeat(10) @(posedge clk);

        // instr = 32'b10101011000000010000000000000110;   // ADDS X6, X0, X1      // X6 = 0
        // Reg2Loc = 1'b1; ALUSrc = 1'b0; MemToReg = 1'b0;
		// RegWrite = 1'b1; MemWrite = 1'b0; ALUOp = 3'b010; 
        // setFlag = 1; shiftSel = 0; immSize = 1'bx; repeat(10) @(posedge clk);

        // instr = 32'b10101011000001010000000000100111;   // ADDS X7, X1, X5      // X7 = -6. Flags: negative, carry-out
        // Reg2Loc = 1'b1; ALUSrc = 1'b0; MemToReg = 1'b0;
		// RegWrite = 1'b1; MemWrite = 1'b0; ALUOp = 3'b010; 
        // setFlag = 1; shiftSel = 0; immSize = 1'bx; repeat(10) @(posedge clk);

        // instr = 32'b10010001000000000000001111111111;    // ADDI X31, X31, #0    // NOOP - should NOT write the flags.
        // Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b010;
        // setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);
        
        // instr = 32'b00010100000000000000000000000000;      // HALT:B HALT          // (HALT = 0)
        // Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        // ALUOp = 3'b010;
        // setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        // -----------------
        instr = 32'b10010001000000000000011111100000;    // ADDI X0, X31, #1     // X0 = 1
        Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b010;
        setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        instr = 32'b10010001000000000000101111100001;    // ADDI X1, X31, #2     // X1 = 2
        Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b010;
        setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        instr = 32'b10010001000000000000111111100010;    // ADDI X2, X31, #3     // X2 = 3
        Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b010;
        setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        instr = 32'b10010001000000000010001111100011;    // ADDI X3, X31, #8     // X3 = 8
        Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b010;
        setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        instr = 32'b10010001000000000010111111100100;    // ADDI X4, X31, #11    // X4 = 11
        Reg2Loc = 1; ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b010;
        setFlag = 0; shiftSel = 0; immSize = 1; repeat(10) @(posedge clk);

        instr = 32'b11111000000000000000001111100000;   // STUR X0, [X31, #0]   // Mem[0] = 1
        Reg2Loc = 1'b0; ALUSrc = 1'b1; MemToReg = 1'bx; RegWrite = 1'b0; MemWrite = 1'b1;
		ALUOp = 3'b010;
		setFlag = 0; shiftSel = 0; immSize = 0; repeat(10) @(posedge clk);

        instr = 32'b11111000000111111101000010000001;   // STUR X1, [X4,  #-3]  // Mem[8] = 2
        Reg2Loc = 1'b0; ALUSrc = 1'b1; MemToReg = 1'bx; RegWrite = 1'b0; MemWrite = 1'b1;
		ALUOp = 3'b010;
		setFlag = 0; shiftSel = 0; immSize = 0; repeat(10) @(posedge clk);

        instr = 32'b11111000000000001000000001100010;   // STUR X2, [X3, #8]    // Mem[16] = 3
        Reg2Loc = 1'b0; ALUSrc = 1'b1; MemToReg = 1'bx; RegWrite = 1'b0; MemWrite = 1'b1;
		ALUOp = 3'b010;
		setFlag = 0; shiftSel = 0; immSize = 0; repeat(10) @(posedge clk);

        instr = 32'b11111000010000000101000010000111;   // LDUR X7, [X4, #5]    // X7 = Mem[16] = 3
        Reg2Loc = 1'bx; ALUSrc = 1'b1; MemToReg = 1'b1; RegWrite = 1'b1; MemWrite = 1'b0;
		ALUOp = 3'b010; 
        setFlag = 0; shiftSel = 0; immSize = 0; repeat(10) @(posedge clk);

        instr = 32'b11111000010111111000000001100101;   // LDUR X5, [X3, #-8]   // X5 = Mem[0] = 1
        Reg2Loc = 1'bx; ALUSrc = 1'b1; MemToReg = 1'b1; RegWrite = 1'b1; MemWrite = 1'b0;
		ALUOp = 3'b010;
		setFlag = 0; shiftSel = 0; immSize = 0; repeat(10) @(posedge clk);

        instr = 32'b11111000010000000101000001000110;   // LDUR X6, [X2, #5]    // X6 = Mem[8] = 2
        Reg2Loc = 1'bx; ALUSrc = 1'b1; MemToReg = 1'b1; RegWrite = 1'b1; MemWrite = 1'b0;
		ALUOp = 3'b010;
		setFlag = 0; shiftSel = 0; immSize = 0; repeat(10) @(posedge clk);

        $stop;

        
    end
endmodule