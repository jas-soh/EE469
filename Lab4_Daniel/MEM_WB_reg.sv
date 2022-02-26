module MEM_WB_reg (clk, reset, regWrite_E_MEM, WriteData_MEM, regWrite_MEM, shiftSel_MEM, 
			shift_output_MEM, regWrite_E_WB, WriteData_WB, regWrite_WB, shiftsel_WB, shift_output_WB); 
    input logic clk, reset;
    input logic regWrite_E_MEM, shiftSel_MEM;
    input logic [63:0] WriteData_MEM, shift_output_MEM;
    input logic [4:0] regWrite_MEM;

    output logic regWrite_E_WB, shiftsel_WB;
    output logic [63:0] WriteData_WB, shift_output_WB;
    output logic [4:0] regWrite_WB;


    D_FF regWrite_E_dff (.q(regWrite_E_WB), .d(regWrite_E_MEM), .reset, .clk);
    D_FF shiftsel_dff (.q(shiftsel_WB), .d(shiftSel_MEM), .reset, .clk);

    register #(64) WriteData_dff (.Din(WriteData_MEM), .Dout(WriteData_WB), .enable(1'b1), .clk, .reset);
    register #(64) shift_output_dff (.Din(shift_output_MEM), .Dout(shift_output_WB), .enable(1'b1), .clk, .reset);

    register #(5) regWrite_dff (.Din(regWrite_MEM), .Dout(regWrite_WB), .enable(1'b1), .clk, .reset);
    
endmodule
