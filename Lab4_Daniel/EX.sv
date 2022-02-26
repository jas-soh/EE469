// TODO EXECUTE stage of the 5 stage pipeline
module EX(ALUSrc, ALUOp, immVal, dataA, dataB, ALUSum, negative, zero, overflow, carry_out);
    input logic ALUSrc;
    input logic [2:0] ALUOp;
    input logic [63:0] dataA, dataB, immVal;

    output logic negative, zero, overflow, carry_out;
    output logic [63:0] ALUSum;
    assign outB = dataB;
    logic [63:0] ALU_inpt_B;
    // 2:1 mux for ALU input B select
	wide_mux2_1 ALU_inpt (.s0(ALUSrc), .A(dataB), .B(immVal), .OUT(ALU_inpt_B));
	
	// ALU implementation 
	alu operation(.A(dataA), .B(ALU_inpt_B), .cntrl(ALUOp), .result(ALUSum), .negative, .zero, .overflow, .carry_out);
    

endmodule
