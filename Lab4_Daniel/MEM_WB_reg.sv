module MEM_WB_reg (clk, reset, regWrite_E_MEM, WriteData_MEM, regWrite_MEM, 
			regWrite_E_WB, WriteData_WB, regWrite_WB); 
    input logic clk, reset;
    input logic regWrite_E_MEM;
    input logic [63:0] WriteData_MEM;
    input logic [4:0] regWrite_MEM;

    output logic regWrite_E_WB;
    output logic [63:0] WriteData_WB;
    output logic [4:0] regWrite_WB;


    D_FF regWrite_E_dff (.q(regWrite_E_WB), .d(regWrite_E_MEM), .reset, .clk);

    register #(64) WriteData_dff (.Din(WriteData_MEM), .Dout(WriteData_WB), .enable(1'b1), .clk, .reset);

    register #(5) regWrite_dff (.Din(regWrite_MEM), .Dout(regWrite_WB), .enable(1'b1), .clk, .reset);
    
endmodule
