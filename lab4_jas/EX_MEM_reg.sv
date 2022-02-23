module EX_MEM_reg (clk, reset, MemWrite_EX, MemToReg_EX, RegWrite_EX, ALU_out_EX, WriteRegister_EX, mem_Din_EX,
    MemWrite_MEM, MemToReg_MEM, RegWrite_MEM, ALU_out_MEM, WriteRegister_MEM, mem_Din_MEM);

    input logic clk, reset;
    input logic MemWrite_EX;
    input logic MemToReg_EX;
    input logic RegWrite_EX;
    input logic [63:0] ALU_out_EX;
    input logic [4:0] WriteRegister_EX;
    input logic [63:0] mem_Din_EX;

    output logic MemWrite_MEM;
    output logic MemToReg_MEM;
    output logic RegWrite_MEM;
    output logic [63:0] ALU_out_MEM;
    output logic [4:0] WriteRegister_MEM;
    output logic [63:0] mem_Din_MEM;

    D_FF MemWrite_dff (.q(MemWrite_MEM), .d(MemWrite_EX), .reset, .clk);
    D_FF MemToReg_dff (.q(MemToReg_MEM), .d(MemToReg_EX), .reset, .clk);
    D_FF RegWrite_dff (.q(RegWrite_MEM), .d(RegWrite_EX), .reset, .clk);

    D_FF_var #(64) ALU_out_dff (.q(ALU_out_MEM), .d(ALU_out_EX), .reset, .clk);
    D_FF_var #(5) WriteRegister_dff (.q(WriteRegister_MEM), .d(WriteRegister_EX), .reset, .clk);
    D_FF_var #(64) mem_Din_dff (.q(mem_Din_MEM), .d(mem_Din_EX), .reset, .clk);

endmodule