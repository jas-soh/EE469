// Jasmine Soh, Daniel Leick


// This module is the main register file that holds the data and updates if write is enabled.
// Then it outputs the data that is selected by an input.
// Inputs:
//             ReadReg1, ReadReg2: the registers to be read from
//                writeReg: the register that data is to be written to
//                WriteData: the 64-bit data to be held in the register at writeReg
// Outputs:
//                ReadData1, ReadData2: the data that is held in the selected registers
module regfile (ReadData1, ReadData2, WriteData, 
					 ReadRegister1, ReadRegister2, WriteRegister,
					 RegWrite, clk);
					 
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0] WriteData;
	input logic clk, RegWrite; 
	output logic [63:0] ReadData1, ReadData2;

	logic [31:0][63:0] registers; 

	
	
	// This portion below is a 5 to 32 decoder that uses four 3:8 decoders and one 2:4 decoder
	// Inputs:
	//            in: 5-bit input
	//            out: 32-bit output that represents which bit was selected by the input
	logic [31:0] regEnable;
	logic [3:0] decodeEn;
	
	decoder2_4 en (.i(WriteRegister[4:3]), .d(decodeEn), .enable(RegWrite));
	decoder3_8 d0d7 (.i(WriteRegister[2:0]), .d(regEnable[7:0]), .enable(decodeEn[0]));
	decoder3_8 d8d15 (.i(WriteRegister[2:0]), .d(regEnable[15:8]), .enable(decodeEn[1]));
	decoder3_8 d16d23 (.i(WriteRegister[2:0]), .d(regEnable[23:16]), .enable(decodeEn[2]));
	decoder3_8 d24d31 (.i(WriteRegister[2:0]), .d(regEnable[31:24]), .enable(decodeEn[3]));
	
	// this portion below constructs the registers
	genvar i;
	generate 
		for (i = 0; i < 31; i++) begin : Creating_registers
			register g (.Din(WriteData), .Dout(registers[i]), .enable(regEnable[i]), .clk, .reset(1'b0));
		end
	endgenerate
	register reg31 (.Din(64'b0), .Dout(registers[31]), .enable(1'b1), .clk, .reset(1'b0));
	
	//initialize the 64 bit wide 32:1 mux
	mux_64x32_1 port1 (.data(registers), .readReg(ReadRegister1), .readData(ReadData1));
	mux_64x32_1 port2 (.data(registers), .readReg(ReadRegister2), .readData(ReadData2));

	
endmodule 