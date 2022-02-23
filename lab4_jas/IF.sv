module IF (clk, reset, instr_addr, instr, branchVal, BrTaken);
    input logic clk, reset;
    input logic [63:0] branchVal;
    output logic instr_addr;
    output logic instr;

    // calculating PC+4
	logic [63:0] PC4;
	assign PC4 = instr_addr + 4; // TODO: adder

    logic [63:0] next_instr_addr; 
    mux2_1_multi #(64) BrTaken_mux (.s0(BrTaken), .a(PC4), .b(branchVal), .out(next_instr_addr));

    instructmem fetch_instr (.address(instr_addr), .instruction(instr), .clk);

    D_FF64 flip_flop (.q(instr_addr), .d(next_instr_addr), .reset, .clk);

endmodule