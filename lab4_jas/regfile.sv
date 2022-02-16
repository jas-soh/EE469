// Daniel Leick
// LAab 1, EE 469
module regfile (ReadData1, ReadData2, WriteData, 
					 ReadRegister1, ReadRegister2, WriteRegister,
					 RegWrite, clk);
					 
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0] WriteData;
	input logic clk, RegWrite; 
	output logic [63:0] ReadData1, ReadData2;

	logic [31:0][63:0] registers; 

	
	
	// decoder with output enable for the registers
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
			register g (.Din(WriteData), .Dout(registers[i]), .enable(regEnable[i]), .clk);
		end
	endgenerate
	register reg31 (.Din(64'b0), .Dout(registers[31]), .enable(1'b1), .clk);
	
	//initialize the 64 bit wide 32:1 mux
	mux_64x32_1 port1 (.data(registers), .readReg(ReadRegister1), .readData(ReadData1));
	mux_64x32_1 port2 (.data(registers), .readReg(ReadRegister2), .readData(ReadData2));

	
endmodule

// Test bench for Register file
`timescale 1ps/1ps
module regfile_testbench ();
	parameter ClockDelay = 5000;
	logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0] WriteData;
	logic clk, RegWrite; 
	logic [63:0] ReadData1, ReadData2;

	regfile dut (.*);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd31;
		ReadRegister2 <= 5'd31;
		WriteRegister <= 5'd31;
		WriteData <= 64'h0000000000000001;
		@(posedge clk);
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd31;
		ReadRegister2 <= 5'd31;
		WriteRegister <= 5'd31;
		WriteData <= 64'h0000000000000001;
		@(posedge clk);
		$stop;
	end


endmodule

// Test bench for Register file
`timescale 1ps/1ps

module regstim(); 		

	parameter ClockDelay = 5000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			RegWrite, clk;
	logic [63:0]	ReadData1, ReadData2;

	integer i;

	// Your register file MUST be named "regfile".
	// Also you must make sure that the port declarations
	// match up with the module instance in this stimulus file.
	regfile dut (.ReadData1, .ReadData2, .WriteData, 
					 .ReadRegister1, .ReadRegister2, .WriteRegister,
					 .RegWrite, .clk);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd0;
		ReadRegister2 <= 5'd0;
		WriteRegister <= 5'd31;
		WriteData <= 64'h00000000000000A0;
		@(posedge clk);
		
		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);

		// Write a value into each  register.
		$display("%t Writing pattern to all registers.", $time);
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000010204080001;
			@(posedge clk);
			
			RegWrite <= 1;
			@(posedge clk);
		end

		// Go back and verify that the registers
		// retained the data.
		$display("%t Checking pattern.", $time);
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
		end
		$stop;
	end
endmodule
 