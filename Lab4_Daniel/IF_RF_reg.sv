module IF_RF_reg (clk, reset, instr_addr_IF, instruction_IF, instr_addr_RF, instruction_RF);
    input logic [63:0] instr_addr_IF;
    input logic [31:0] instruction_IF;
    input logic clk, reset;
    
    output logic [63:0] instr_addr_RF;
    output logic [31:0] instruction_RF;

    register (#64) program_counter_dff (.Din(instr_addr_IF), .Dout(instr_addr_RF), .enable(1'b1), .clk, .reset);
    register (#32) instruction_dff (.Din(instruction_IF), .Dout(instruction_RF), .enable(1'b1), .clk, .reset);
endmodule