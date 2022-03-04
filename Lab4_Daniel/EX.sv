// EXECUTE stage of the 5 stage 
/*Inputs:
    - ALUSrc: control signal to choose from DataB or immVal as imput B of ALU
    - ALUOp: ALU operation
    - immVal: immediate value that may go into ALU
    - dataA: output from regFile, input to ALU
    - dataB: output from regFile, possible input to ALU
    - shift_result: result from shifter
    - shiftSel: control to choose shiftSel or ALU out as output 
Outputs:
    - Flags: negative, zero, overflow, carry_out
    - execute_output: output from execute stage, from ALUE or shifter
    */
module EX(ALUSrc, ALUOp, immVal, dataA, dataB, execute_output, negative, zero, overflow, carry_out, shiftSel, shift_result);
    input logic ALUSrc, shiftSel;
    input logic [2:0] ALUOp;
    input logic [63:0] dataA, dataB, immVal, shift_result;

    output logic negative, zero, overflow, carry_out;
    output logic [63:0] execute_output;
    
    logic [63:0] ALU_inpt_B, ALUSum;
    // 2:1 mux for ALU input B select
	wide_mux2_1 ALU_inpt (.s0(ALUSrc), .A(dataB), .B(immVal), .OUT(ALU_inpt_B));
	
	// ALU implementation 
	alu operation(.A(dataA), .B(ALU_inpt_B), .cntrl(ALUOp), .result(ALUSum), .negative, .zero, .overflow, .carry_out);
    
    //2:1 mux to choose frm alu output or shift output
    wide_mux2_1 ALUOrshift (.s0(shiftSel), .A(ALUSum), .B(shift_result), .OUT(execute_output));
endmodule
