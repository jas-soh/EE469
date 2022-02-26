module EX_MEM_reg (clk, reset, memWrite_E_EX, MemToReg_EX, regWrite_E_EX, mem_read_EX,
    ALU_out_EX, regWrite_EX, mem_Din_EX, shift_output_EX, shiftSel_EX,
    memWrite_E_MEM, MemToReg_MEM, regWrite_E_MEM, mem_read_MEM, ALU_out_MEM,
    regWrite_MEM, mem_Din_MEM, shift_output_MEM, shiftSel_MEM);

    input logic clk, reset;
    input logic memWrite_E_EX;
    input logic MemToReg_EX;
    input logic regWrite_E_EX;
    input logic mem_read_EX, shiftSel_EX;
    input logic [63:0] ALU_out_EX;
    input logic [4:0] regWrite_EX;
    input logic [63:0] mem_Din_EX, shift_output_EX;

    output logic memWrite_E_MEM;
    output logic MemToReg_MEM;
    output logic regWrite_E_MEM;
    output logic mem_read_MEM, shiftSel_MEM;
    output logic [63:0] ALU_out_MEM;
    output logic [4:0] regWrite_MEM;
    output logic [63:0] mem_Din_MEM, shift_output_MEM;

    D_FF MemWrite_dff (.q(memWrite_E_MEM), .d(memWrite_E_EX), .reset, .clk);
    D_FF MemToReg_dff (.q(MemToReg_MEM), .d(MemToReg_EX), .reset, .clk);
    D_FF RegWrite_dff (.q(regWrite_E_MEM), .d(regWrite_E_EX), .reset, .clk);
	 D_FF mem_read_dff (.q(mem_read_MEM), .d(mem_read_EX), .reset, .clk);
	 D_FF shiftSel_dff (.q(shiftSel_MEM), .d(shiftSel_EX), .reset, .clk);

    register #(64) ALU_out_dff (.Din(ALU_out_EX), .Dout(ALU_out_MEM), .enable(1'b1), .clk, .reset);
    register #(5) WriteRegister_dff (.Din(regWrite_EX), .Dout(regWrite_MEM), .enable(1'b1), .clk, .reset);
    register #(64) mem_Din_dff (.Din(mem_Din_EX), .Dout(mem_Din_MEM), .enable(1'b1), .clk, .reset);
	 register #(64) shift_output_dff (.Din(shift_output_EX), .Dout(shift_output_MEM), .enable(1'b1), .clk, .reset);

endmodule