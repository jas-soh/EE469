module program_counter ( instruction, UncondBr, BrTaken, clk, reset);
//	input logic [63:0] instr_addr; // address of instruction
	output logic [31:0] instruction;
	input logic UncondBr, BrTaken; // control inputs
	input logic clk, reset;
	
	logic [63:0] instr_addr;
	
	// calculating PC+4
	logic [63:0] PC4;
	assign PC4 = instr_addr + 4;
	
	
	// sign extend condAddr19 and BrAddr26 then shift left by 2
	logic [63:0] SE_condAddr19, SE_BrAddr26;
	// need to update this value
	
	// shift SE BrAddr26 and SE condAddr19
	shifter shiftBrAddr(.value({{38{instruction[25]}}, instruction[25:0]}),.direction(1'b0),.distance(6'd2),.result(SE_BrAddr26));
	shifter shiftcondAddr(.value({{45{instruction[23]}}, instruction[23:5]}),.direction(1'b0),.distance(6'd2),.result(SE_condAddr19));
	
	// 2:1 Mux to choose condAddr or BrAddr based on UncondBr control signal
	logic [63:0] addr;
	wide_mux2_1  UncondBr_mux (.s0(UncondBr), .A(SE_condAddr19), .B(SE_BrAddr26), .OUT(addr));
	
	// add PC and branch value 
	// PC + SE(Addr) << 2
	logic [63:0] sum_PCandImm;
	logic carry_PCandImm;
	// TODO - ADD64 NOT IN THIS PROJECT
	add_width PCandImm (.A(addr), .B(instr_addr), .cIn(1'b0), .s(sum_PCandImm), .cOut(carry_PCandImm));
	
	// 2:1 Mux to choose between PC+4 and PC+addr
	logic [63:0] nextPC;
	wide_mux2_1  BrTaken_mux (.s0(BrTaken), .A(PC4), .B(sum_PCandImm), .OUT(nextPC));
	
	// implement PC
	register PC (.Din(nextPC), .Dout(instr_addr), .enable(1'b1), .clk, .reset);
	
	// instruction mem
	// TODO NEVER UPDATING INSTR_ADDR
	instructmem instr (.address(instr_addr), .instruction, .clk);
	
	
endmodule


`timescale 1ps/1ps
module program_counter_testbench ();
	logic [63:0] instr_addr; // address of instruction
	logic [31:0] instruction;
	logic UncondBr, BrTaken, clk, reset; // control inputs

	program_counter dut (.*);
	
	parameter CLOCK_PERIOD=5000;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end

	initial begin
		reset <= 1'b1; UncondBr <= 1'b0; BrTaken <= 1'b0;  @(posedge clk);
		reset <= 1'b0; 									repeat(1)@(posedge clk);
//		while
//		if (instruction == 32'b000101_00000000000000000000001100) begin
//		UncondBr <= 1'b0; BrTaken <= 1'b0;  @(posedge clk);// B FORWARD_B          // 1st taken branch (+12)
//		// test with branches next
//		reset <= 1'b1;					
//		reset <= 1'b0;
	// end
		$stop;
	end
endmodule

