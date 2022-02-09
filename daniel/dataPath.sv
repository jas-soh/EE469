
// need to test this  
module dataPath(instruction, Reg2Loc, RegWrite, 
					ALUSrc, ALUOp, MemWrite, MemToReg,
					immSize, shiftSel, clk,
					negative, zero, overflow, carry_out);
	
	input logic [31:0] instruction;
	input logic [2:0] ALUOp;
	input logic Reg2Loc, RegWrite, ALUSrc, MemWrite, 
					MemToReg, immSize, shiftSel, clk;
	output logic negative, zero, overflow, carry_out;
	
	logic [63:0] ALU_result;
	logic [63:0] mem_out;
	logic [4:0] Ab_in;
	
	logic [63:0] Da_out, Db_out, mem_ALU_out,
					 imm12_ZE, imm9_SE, ALU_inpt_B, immediate_val, shift_out, 
					 reg_dataWrite;
	
	// 2:1 mux to choose regFile Ab output .a when input s0 is 0
	//  
	wide_mux2_1 #(5) reg_input_Ab (.s0(Reg2Loc), .A(instruction[4:0]), .B(instruction[20:16]), .OUT(Ab_in));  
	
	// mux to decide regFile data write either shiftout or mem_alu_out
	wide_mux2_1 shiftDat (.s0(shiftSel), .A(mem_ALU_out), .B(shift_out), .OUT(reg_dataWrite));
	
	// RegFile 
	regfile regist (.ReadData1(Da_out), .ReadData2(Db_out), .WriteData(reg_dataWrite), 
							.ReadRegister1(instruction[9:5]), .ReadRegister2(Ab_in), .WriteRegister(instruction[4:0]),
							.RegWrite, .clk);
							
	// sign extend imm12; zero extend imm9
	assign imm12_ZE = {{52'd0}, {instruction[21:10]}};
	assign imm9_SE = {{56{instruction[20]}}, {instruction[19:12]}};
	
	//2:1 mux to select immediate value
	wide_mux2_1 imm_sel (.s0(immSize), .A(imm9_SE), .B(imm12_ZE), .OUT(immediate_val));
	
	// 2:1 mux for ALU input B select
	wide_mux2_1 ALU_inpt (.s0(ALUSrc), .A(Db_out), .B(immediate_val), .OUT(ALU_inpt_B));
	
	// ALU implementation - how do we organize output flags?
	alu operation(.A(Da_out), .B(ALU_inpt_B), .cntrl(ALUOp), .result(ALU_result), .negative, .zero, .overflow, .carry_out);
	
	
	// implement shifter
	shifter shif (.value(Da_out), .direction(1'b1), .distance(instruction[15:10]), .result(shift_out));
	
	// data memory
	datamem dat (.address(ALU_result), .write_enable(MemWrite), .read_enable(1'b1),
					 .write_data(Db_out), .clk, .xfer_size(4'd8), .read_data(mem_out));
					 
	wide_mux2_1 memTo (.s0(MemToReg), .A(ALU_result), .B(mem_out), .OUT(mem_ALU_out));
	
	

endmodule

`timescale 1ps/1ps
module dataPath_testbench();
	logic [31:0] instruction;
	logic [2:0] ALUOp;
	logic Reg2Loc, RegWrite, ALUSrc, MemWrite, 
			MemToReg, immSize, shiftSel, clk;
	logic negative, zero, overflow, carry_out;

	parameter ClockDelay = 10000;

    dataPath dut (.*);

    initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    initial begin
        instruction = 32'b1001000100_000000000001_11111_00000;    // ADDI X0, X31, #1     // X0 =  1
        ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b010; Reg2Loc = 1'b?;
        shiftSel = 0; immSize = 1;  repeat(5)@(posedge clk);
		  
		  instruction = 32'b11101011000_00000_000000_11111_00001;   // SUBS X1, X31, X0     // X1 = -1;
        ALUSrc = 1'b0; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
        ALUOp = 3'b011; Reg2Loc = 1'b1;
        shiftSel = 1'b0; immSize = 1;  repeat(5)@(posedge clk);

//        instr = 32'b10010001000000000000010000000001;
//        ALUSrc = 1'b1; MemToReg = 1'b0; RegWrite = 1'b1; MemWrite = 1'b0;
//        ALUOp = 3'b100; setFlag = 0; 
//        setFlag = 0; shiftSel = 0; immSize = 1; 
//        shamt = 6'b0; @(posedge clk);

    $stop;
	 end
endmodule


