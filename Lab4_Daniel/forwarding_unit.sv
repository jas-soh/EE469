module forwarding_unit(addr_A, addr_B, write_reg_mem, regWrite_E_mem, write_reg_alu, regWrite_E_alu);
    input logic [4:0] addr_A, addr_B, write_reg_mem, write_reg_alu;
    input logic regWrite_E_mem, regWrite_E_alu;

    output logic [2:0] forwardOp_A, forwardOp_B;

// 1.)  What happens if an instruction writes back to register 31, which is required to 
// always be 0 regardless of what is written to that register? 
// 2.)  The ALU and the Memory can each provide values to be written to the register 
// file, and thus may both be sources of forward information (though you may 
// cleverly be able to combine some of this). 
// 3.)  The ALU, branch logic, and memory can all need values from the register files, 
// and thus may need to have values forwarded to them. 
// 4.)  Not all instructions write registers, and different instructions have register IDs at 
// different places in the instruction word.  These should be carefully considered. 

    always_comb begin
        if (write_reg_mem)

endmodule