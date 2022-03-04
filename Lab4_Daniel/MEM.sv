// memory stage of the 5 stage pipelined CPU
/*Inputs:
    - clk, reset
    - MemWrite: write enable to memory
    - mem_read: read enable for memory
    - memToReg: control to select between mem_addr and output form memory
    - dataMem_in: inout to be written to memory
    - mem_addr: address for memory read

Outputs:
    - writeBack: output from MEM stage to be written back to regfile */
module MEM (clk, reset, MemWrite, dataMem_in, mem_addr, writeBack, mem_read, memToReg);
    input logic clk, reset, MemWrite, mem_read, memToReg;
    input logic [63:0] dataMem_in, mem_addr;

    output logic [63:0] writeBack;
    
    logic [63:0] mem_out;

    datamem mem (.address(mem_addr), .write_enable(MemWrite), .read_enable(mem_read),
				 .write_data(dataMem_in), .clk, .xfer_size(4'd8), .read_data(mem_out));
    
    wide_mux2_1 writeSel (.s0(memToReg), .A(mem_addr), .B(mem_out), .OUT(writeBack));

endmodule
