module RF_EX_reg (clk, reset, dataA_RF, dataB_RF, immVal_RF, shift_output_RF, ALUSrc_RF, memWrite_E_RF, MemToReg_RF, regWrite_E_RF,
            mem_read_RF, setFlag_RF, shiftSel_RF, regWrite_RF, ALUOp_RF, dataA_EX, dataB_EX, immVal_EX, shift_output_EX,
            ALUSrc_EX, memWrite_E_EX, MemToReg_EX, regWrite_E_EX,mem_read_EX, setFlag_EX, shiftSel_EX, regWrite_EX, ALUOp_EX);

input logic [63:0] dataA_RF, dataB_RF, immVal_RF, shift_output_RF;
input logic ALUSrc_RF, memWrite_E_RF, MemToReg_RF, regWrite_E_RF,
             mem_read_RF, setFlag_RF, shiftSel_RF, clk, reset;
input logic [4:0] regWrite_RF;
input logic [2:0] ALUOp_RF;

output logic [63:0] dataA_EX, dataB_EX, immVal_EX, shift_output_EX;
output logic ALUSrc_EX, memWrite_E_EX, MemToReg_EX, regWrite_E_EX,
             mem_read_EX, setFlag_EX, shiftSel_EX;
output logic [4:0] regWrite_EX;
output logic [2:0] ALUOp_EX;

register (#64) dataA_reg (.Din(dataA_RF), .Dout(dataA_EX), .enable(1'b1), .clk, .reset);
register (#64) dataB_reg (.Din(dataB_RF), .Dout(dataB_EX), .enable(1'b1), .clk, .reset);
register (#64) immVal_reg (.Din(immVal_RF), .Dout(immVal_EX), .enable(1'b1), .clk, .reset);
register (#64) shift_output_reg (.Din(shift_output_RF), .Dout(shift_output_EX), .enable(1'b1), .clk, .reset);

register (#5) regWrite_reg (.Din(regWrite_RF), .Dout(regWrite_EX), .enable(1'b1), .clk, .reset);
register (#3) ALUOp_reg (.Din(ALUOp_RF), .Dout(ALUOp_EX), .enable(1'b1), .clk, .reset);

D_FF ALUSrc_reg (.q(ALUSrc_EX), .d(ALUSrc_RF), .reset, .clk);
D_FF memWrite_E_reg (.q(memWrite_E_EX), .d(memWrite_E_RF), .reset, .clk);
D_FF MemToReg_reg (.q(MemToReg_EX), .d(MemToReg_RF), .reset, .clk);
D_FF regWrite_E_reg (.q(regWrite_E_EX), .d(regWrite_E_RF), .reset, .clk);
D_FF mem_read_reg (.q(mem_read_EX), .d(mem_read_RF), .reset, .clk);
D_FF setFlag_reg (.q(setFlag_EX), .d(setFlag_RF), .reset, .clk);
D_FF shiftSel_reg (.q(shiftSel_EX), .d(shiftSel_RF), .reset, .clk);


endmodule