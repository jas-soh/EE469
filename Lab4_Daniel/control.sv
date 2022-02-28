
// control unit that outputs coresponding control flag based on instruction
// Handles ADDI, ADDS, AND, LDUR, EOR, LSR, STUR, SUBS, B, B.LT, CBZ   
module control(instr, mem_read, zeroFlag, Reg2Loc, ALUSrc, MemToReg, 
					RegWrite, MemWrite, BrTaken, UncondBr, ALUOp, setFlag, 
					immSize, shiftSel, negative, overflow);
	input logic [31:0] instr;
	input logic zeroFlag, negative, overflow;
	output logic Reg2Loc, ALUSrc,
		MemToReg, RegWrite,
		MemWrite, BrTaken,
		UncondBr, immSize, shiftSel, mem_read;
	output logic [2:0] ALUOp;
	output logic setFlag;
	
	always_comb begin
		// ---- R type ----
		// ADDI - had error in aluOP
		// ADDI Rd, Rn, Imm12: Reg[Rd] = Reg[Rn] + ZeroExtend(Imm12). 
		if (instr[31:22] == 10'h244) begin
			Reg2Loc = 1'bx;
			ALUSrc = 1'b1;
			MemToReg = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			BrTaken = 1'b0;
			UncondBr = 1'bx;
			ALUOp = 3'b010;
			immSize = 1'b1;
			shiftSel = 1'b0;
			mem_read = 1'b0;
			// ----
			setFlag = 1'b0;
		end

		// ADDS - had error in aluOP
		// ADDS Rd, Rn, Rm: Reg[Rd] = Reg[Rn] + Reg[Rm]. Set flags.
		else if (instr[31:21] == 11'h558) begin
			Reg2Loc = 1'b1;
			ALUSrc = 1'b0;
			MemToReg = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			BrTaken = 1'b0;
			UncondBr = 1'bx;
			ALUOp = 3'b010;
			immSize = 1'bX;
			shiftSel = 1'b0;
			mem_read = 1'b0;
			// ----
			setFlag = 1'b1;
		end

		// AND - had error in aluOP
		// AND Rd, Rn, Rm: Reg[Rd] = Reg[Rn] & Reg[Rm]. 
		else if (instr[31:21] == 11'h450) begin
			Reg2Loc = 1'b1;
			ALUSrc = 1'b0;
			MemToReg = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			BrTaken = 1'b0;
			UncondBr = 1'bx;
			ALUOp = 3'b100;
			immSize = 1'bX;
			shiftSel = 1'b0;
			mem_read = 1'b0;
			// ----
			setFlag = 1'b0;
		end
		
		// LDUR
		// LDUR Rd, [Rn, #Imm9]: Reg[Rd] = Mem[Reg[Rn] + SignExtend(Imm9)]. 
		else if (instr[31:21] == 11'h7C2) begin
			Reg2Loc = 1'bx;
			ALUSrc = 1'b1;
			MemToReg = 1'b1;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			BrTaken = 1'b0;
			UncondBr = 1'bx;
			ALUOp = 3'b010;
			immSize = 1'b0;
			shiftSel = 1'b0;
			mem_read = 1'b1;
			// ----
			setFlag = 1'b0;
		end
		
		//  
		// EOR Rd, Rn, Rm: Reg[Rd] = Reg[Rn] ^ Reg[Rm].
		else if (instr[31:21] == 11'h650) begin
			Reg2Loc = 1'b1;
			ALUSrc = 1'b0;
			MemToReg = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			BrTaken = 1'b0;
			UncondBr = 1'bx;
			ALUOp = 3'b110;
			immSize = 1'bX;
			shiftSel = 1'b0;
			mem_read = 1'b0;
			// ----
			setFlag = 1'b0;
		end

		// LSR
		// LSR Rd, Rn, Shamt: Reg[Rd] = Reg[Rn] >> Shamt 
		else if (instr[31:21] == 11'h69A) begin
			Reg2Loc = 1'bx;
			ALUSrc = 1'bx;
			MemToReg = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			BrTaken = 1'b0;
			UncondBr = 1'bx;
			ALUOp = 3'bxxx;
			immSize = 1'bX;
			shiftSel = 1'b1;
			mem_read = 1'b0;
			// ----
			setFlag = 1'b0;
		end

		// STUR 
		// STUR Rd, [Rn, #Imm9]: Mem[Reg[Rn] + SignExtend(Imm9)] = Reg[Rd].
		else if (instr[31:21] == 11'h7C0) begin
			Reg2Loc = 1'b0;
			ALUSrc = 1'b1;
			MemToReg = 1'bX;
			RegWrite = 1'b0;
			MemWrite = 1'b1;
			BrTaken = 1'b0;
			UncondBr = 1'bx;
			ALUOp = 3'b010;
			immSize = 1'b0;
			shiftSel = 1'b0;
			mem_read = 1'b1;
			// ----
			setFlag = 1'b0;
		end

		// SUBS
		// SUBS Rd, Rn, Rm: Reg[Rd] = Reg[Rn] - Reg[Rm].  Set flags. 
		else if (instr[31:21] == 11'h758) begin
			Reg2Loc = 1'b1;
			ALUSrc = 1'b0;
			MemToReg = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			BrTaken = 1'b0;
			UncondBr = 1'bx;
			ALUOp = 3'b011;
			immSize = 1'bX;
			shiftSel = 1'b0;
			mem_read = 1'b0;
			// -----
			setFlag = 1'b1;
		end
		
		
		// ---- CB-type ----
		// B
        // B Imm26: PC = PC + SignExtend(Imm26 << 2). 
		else if (instr[31:26] == 6'h05) begin
			Reg2Loc = 1'bx;
			ALUSrc = 1'bx;
			MemToReg = 1'bx;
			RegWrite = 1'b0;
			MemWrite = 1'b0;
			BrTaken = 1'b1;
			UncondBr = 1'b1;
			ALUOp = 3'bx;
			immSize = 1'bX;
			shiftSel = 1'bX;
			mem_read = 1'b0;
         // ----
         setFlag = 1'b0;
		end

		// B.LT insert extra condition with flags
      // B.LT Imm19: If (flags.negative != flags.overflow) PC = PC + SignExtend(Imm19<<2). 
		else if ((instr[31:24] == 8'h54) && (instr[4:0] == 5'h0B) && (negative != overflow)) begin
			Reg2Loc = 1'bx;
			ALUSrc = 1'bx;
			MemToReg = 1'bx;
			RegWrite = 1'b0;
			MemWrite = 1'b0;
			BrTaken = 1'b1; 
			UncondBr = 1'b0;
			ALUOp = 3'bx;
			immSize = 1'bX;
			shiftSel = 1'bX;
			mem_read = 1'b0;
         // ----
         setFlag = 1'b0;
		end
		
		// CBZ
        // CBZ Rd, Imm19: If (Reg[Rd] == 0) PC = PC + SignExtend(Imm19<<2). 
		else if (instr[31:24] == 8'hB4) begin
			Reg2Loc = 1'b0;
			ALUSrc = 1'b0;
			MemToReg = 1'bx;
			RegWrite = 1'b0;
			MemWrite = 1'b0;
			BrTaken = zeroFlag; // zero flag
			UncondBr = 1'b0;
			ALUOp = 3'b000;
			immSize = 1'bX;
			shiftSel = 1'bX;
			mem_read = 1'b0;
         // ----
         setFlag = 1'b0;
		end
		
		else begin //always_comb is always going here
			Reg2Loc = 1'bX;
			ALUSrc = 1'bX;
			MemToReg = 1'bx;
			RegWrite = 1'b0;
			MemWrite = 1'b0;
			BrTaken = 1'b0; // zero flag
			UncondBr = 1'bX;
			ALUOp = 3'bXXX;
			immSize = 1'bX;
			shiftSel = 1'bX;
			mem_read = 1'b0;
         // ----
         setFlag = 1'b0;
		end
	end
	
endmodule 

`timescale 1ps/1ps
module control_testbench ();
    logic [31:0] instr;
	logic zeroFlag;
    logic Reg2Loc, ALUSrc,
		MemToReg, RegWrite,
		MemWrite, BrTaken,
		UncondBr, immSize, shiftSel,
		negative, overflow, mem_read;
	logic [2:0] ALUOp;
	logic setFlag;

    control dut (.*);

    initial begin
        // ADDI
		// ADDI Rd, Rn, Imm12: Reg[Rd] = Reg[Rn] + ZeroExtend(Imm12)
        instr = 32'b10010001000000000000001111100000;  zeroFlag = 1'bX; #10; // ADDI X0, X31, #0     // X0 = 0
        assert ((ALUSrc == 1'b1) && (MemToReg == 1'b0) && (RegWrite == 1'b1)
			&& (MemWrite == 1'b0) && (BrTaken == 1'b0) && (ALUOp == 3'b010) && (setFlag == 0));

        instr = 32'b10010001000000000000010000000001;  zeroFlag = 1'bx; #10; // ADDI X1, X0, #1      // X1 = 1
        assert ((ALUSrc == 1'b1) && (MemToReg == 1'b0) && (RegWrite == 1'b1)
			&& (MemWrite == 1'b0) && (BrTaken == 1'b0) && (ALUOp == 3'b010) && (setFlag == 0));

        instr = 32'b10010001000000000000010000100010; zeroFlag = 1'bx; #10; // ADDI X2, X1, #1      // X2 = 2
        assert ((ALUSrc == 1'b1) && (MemToReg == 1'b0) && (RegWrite == 1'b1)
			&& (MemWrite == 1'b0) && (BrTaken == 1'b0) && (ALUOp == 3'b010) && (setFlag == 0));

        instr = 32'b10010001000000000000100000100011; zeroFlag = 1'bx; #10; // ADDI X3, X1, #2      // X3 = 3
        assert ((ALUSrc == 1'b1) && (MemToReg == 1'b0) && (RegWrite == 1'b1)
			&& (MemWrite == 1'b0) && (BrTaken == 1'b0) && (ALUOp == 3'b010) && (setFlag == 0));

        instr = 32'b10010001000000000001000000000100; zeroFlag = 1'bx; #10; // ADDI X4, X0, #4      // X4 = 4
        assert ((ALUSrc == 1'b1) && (MemToReg == 1'b0) && (RegWrite == 1'b1)
			&& (MemWrite == 1'b0) && (BrTaken == 1'b0) && (ALUOp == 3'b010) && (setFlag == 0));

    end

endmodule