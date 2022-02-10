module updateFlag (reset, setFlag, negFlag, ALUzeroFlag, ovFlag, branch, zeroFlag);
    input logic setFlag, reset;
    input logic negFlag, ALUzeroFlag, ovFlag;
    output logic branch, zeroFlag;

    always_comb begin
        if (reset) begin
            zeroFlag = 0;
            branch = 0;
        end
        else if (setFlag) begin
            zeroFlag = ALUzeroFlag;

            // if negative flag != overflow flag
            // or ALUzeroflag
            if (negFlag != ovFlag) begin
                branch = 1;
            end
            else branch = 0;
        end
    
        else begin
            zeroFlag = zeroFlag;
            branch = branch;
        end
    end
endmodule

module updateFlag_testbench ();
    logic setFlag, reset;
    logic negFlag, ALUzeroFlag, ovFlag;
    logic branch, zeroFlag;

    updateFlag dut (.*);

    initial begin
        reset = 1; setFlag = 0; negFlag = 0; ALUzeroFlag = 0; ovFlag = 0; #10;
        
        reset = 0; setFlag = 0; negFlag = 0; ALUzeroFlag = 0; ovFlag = 0; #10;
        assert ((branch == 0) && (zeroFlag == 0));

        reset = 0; setFlag = 1; negFlag = 0; ALUzeroFlag = 0; ovFlag = 0; #10;
        assert ((branch == 0) && (zeroFlag == 0));

        // test that nothing changes
        reset = 0; setFlag = 0; negFlag = 0; ALUzeroFlag = 0; ovFlag = 0; #10;
        assert ((branch == 0) && (zeroFlag == 0));

        // test that branch changes to 1
        reset = 0; setFlag = 1; negFlag = 1; ALUzeroFlag = 0; ovFlag = 0; #10;
        assert ((branch == 1) && (zeroFlag == 0));

        // change branch to 0 again
        reset = 0; setFlag = 1; negFlag = 0; ALUzeroFlag = 0; ovFlag = 0; #10;
        assert ((branch == 0) && (zeroFlag == 0));

        // change branch to 1 again using other condition
        reset = 0; setFlag = 1; negFlag = 0; ALUzeroFlag = 1; ovFlag = 0; #10;
        assert ((branch == 1) && (zeroFlag == 1));
    end
endmodule