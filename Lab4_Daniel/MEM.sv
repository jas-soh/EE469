
module MEM (clk, reset, MemWrite, dataMem_in, mem_addr, writeBack, mem_read, memToReg);
    input logic clk, reset, MemWrite, mem_read, memToReg;
    input logic [63:0] dataMem_in, mem_addr;

    output logic [63:0] writeBack;
    
    logic [63:0] mem_out;

    datamem mem (.address(mem_addr), .write_enable(MemWrite), .read_enable(mem_read),
				 .write_data(dataMem_in), .clk, .xfer_size(4'd8), .read_data(mem_out));
    
    wide_mux2_1 writeSel (.s0(memToReg), .A(mem_addr), .B(mem_out), .OUT(writeBack));

endmodule
