// TODO - WRITEBACK
module WB(mem_alu_out, shift_output, shift_sel, data_write);
    input logic [63:0] mem_alu_out, shift_output;
    input logic shift_sel;

    output logic [63:0] data_write;

    wide_mux2_1 writebac (.s0(shift_sel), .A(mem_alu_out), .B(shift_output), .OUT(data_write));
endmodule