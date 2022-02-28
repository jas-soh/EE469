module forwarding_unit(addr_A, addr_B, write_reg_mem, regWrite_E_mem, write_reg_alu, regWrite_E_alu, 
                        forwardOp_A, forwardOp_B, instr_31_to_25_EX, cur_instr_31_24, forwardOpflags);
    input logic [4:0] addr_A, addr_B, write_reg_mem, write_reg_alu;
    input logic regWrite_E_mem, regWrite_E_alu;
    input logic [6:0] instr_31_to_25_EX;
    input logic [7:0] cur_instr_31_24;

    output logic [1:0] forwardOp_A, forwardOp_B;
    output logic forwardOpflags;

    // 3:1 mux for forwarding data
    // sel = 00 ---> not forwarding; mux selects register
    // sel = 01 ---> forwarding from alu output
    // sel = 10 ---> forwarding from memory
    always_comb begin
        // forward alu output to the RF - addrA
        if ((write_reg_alu == addr_A) && (regWrite_E_alu == 1'b1) && (write_reg_alu != 5'd31)) begin
            forwardOp_A = 2'b01;
        end
        // forward mem out to RF - addrA
        else if ((write_reg_mem == addr_A) && (regWrite_E_mem == 1'b1) && (write_reg_mem != 5'd31)) begin
            forwardOp_A = 2'b10;
        end else begin
            forwardOp_A = 2'b00;
        end

        // forward alu output to the RF - addrB
        if ((write_reg_alu == addr_B) && (regWrite_E_alu == 1'b1) && (write_reg_alu != 5'd31)) begin
            forwardOp_B = 2'b01;
        end
        // forward mem out to RF - addrB
        else if ((write_reg_mem == addr_B) && (regWrite_E_mem == 1'b1) && (write_reg_mem != 5'd31)) begin
            forwardOp_B = 2'b10;
        end else begin
            forwardOp_B = 2'b00;
        end

        // forwarding execute flags
        // if instruction ahead is ADDS or SUBS && current instruction is CB type
        if (instr_31_to_25_EX == 7'h75 && (cur_instr_31_24 == 8'h54 || cur_instr_31_24 == 8'hB4 || cur_instr_31_24 == 8'hB5)) begin
            forwardOpflags = 1'b1;
        end else begin
            forwardOpflags = 1'b0;
        end
    end
endmodule