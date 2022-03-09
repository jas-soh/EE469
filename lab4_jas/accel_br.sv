module accel_br (instr_ID, Db_ID, setFlag_EX, accel_zero, accel_lt);
    input logic [31:0] instr_ID;
    input logic setFlag_EX;
    //input logic [31:0] instr_ID;
    input logic [63:0] Db_ID;
    output logic accel_zero, accel_lt;

    always_comb begin
        //if ((instr[31:24] == 8'hB4) && (instr[4:0] == WriteRegister_ID) && (Db_ID == 0)) begin
        if ((instr_ID[31:24] == 8'hB4) && (Db_ID == 0)) begin
            accel_zero = 1;
        end
        else accel_zero = 0;

        if ((instr_ID[31:24] == 8'h54) && (setFlag_EX)) begin
            accel_lt = 1;
        end
        else accel_lt = 0;
    end
endmodule