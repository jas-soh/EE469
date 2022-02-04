module program_counter (instr_addr, instruction, UncondBr, BrTaken);
	input logic [63:0] instr_addr; // address of instruction
	input logic [31:0] instruction;
	input logic UncondBr, BrTaken; // control inputs
	
	
	// calculating PC+4
	logic [63:0] PC4;
	assign PC4 = instr_addr + 4;
	
	
	// sign extend condAddr19 and BrAddr26 then shift left by 2
	logic [63:0] SE_condAddr19, SE_BrAddr26;
	assign SE_BrAddr26 = {{38{instruction[25]}}, instruction[25:0]} << 2;
	assign SE_condAddr19 = {{45{instruction[23]}}, instruction[23:5]} << 2;
	
	// 2:1 Mux to choose condAddr or BrAddr based on UncondBr control signal
	logic [63:0] addr;
	mux2_1 UncondBr_mux (.s0(UncondrBr), .a(SE_CondAddr19), .b(SE_CondBrAddr26), .out(addr));
	
	// add PC and branch value 
	// PC + SE(Addr) << 2
	logic [63:0] sum_PCandImm, carry_PCandImm;
	add64 PCandImm (.A(addr), .B(instr_addr), .subtract_signal(1'b0), .sum(sum_PCandImm), .carry_out(carry_PCandImm));
	
	// 2:1 Mux to choose between PC+4 and PC+addr
	logic [63:0] nextPC;
	mux2_1 BrTaken_mux (.s0(BrTaken), .a(PC4), .b(sum_PCandImm), .out(nextPC));
	
	
endmodule

module program_counter_testbench ();
	logic [63:0] instr_addr; // address of instruction
	logic [31:0] instruction;
	logic UncondBr, BrTaken; // control inputs

	program_counter dut (.*);

	// initial begin
		// instr_addr = {64{1'b1}}; instruction = ; UncondBr = 0; BrTaken = 0; #10;
		// instr_addr = {64{1'b1}}; instruction = ; UncondBr = 0; BrTaken = 0; #10;
		// instr_addr = {64{1'b1}}; instruction = ; UncondBr = 0; BrTaken = 0; #10;
		// instr_addr = {64{1'b1}}; instruction = ; UncondBr = 0; BrTaken = 0; #10;
	// end
endmodule