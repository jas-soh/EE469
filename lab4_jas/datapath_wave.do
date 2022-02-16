onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_testbench/ClockDelay
add wave -noupdate /datapath_testbench/instr
add wave -noupdate /datapath_testbench/Reg2Loc
add wave -noupdate /datapath_testbench/ALUSrc
add wave -noupdate /datapath_testbench/MemToReg
add wave -noupdate /datapath_testbench/RegWrite
add wave -noupdate /datapath_testbench/MemWrite
add wave -noupdate /datapath_testbench/ALUOp
add wave -noupdate /datapath_testbench/setFlag
add wave -noupdate /datapath_testbench/shiftSel
add wave -noupdate /datapath_testbench/immSize
add wave -noupdate /datapath_testbench/clk
add wave -noupdate /datapath_testbench/ALUzeroFlag
add wave -noupdate /datapath_testbench/negFlag
add wave -noupdate /datapath_testbench/ovFlag
add wave -noupdate -radix decimal -childformat {{{/datapath_testbench/dut/register/registers[31]} -radix decimal} {{/datapath_testbench/dut/register/registers[30]} -radix decimal} {{/datapath_testbench/dut/register/registers[29]} -radix decimal} {{/datapath_testbench/dut/register/registers[28]} -radix decimal} {{/datapath_testbench/dut/register/registers[27]} -radix decimal} {{/datapath_testbench/dut/register/registers[26]} -radix decimal} {{/datapath_testbench/dut/register/registers[25]} -radix decimal} {{/datapath_testbench/dut/register/registers[24]} -radix decimal} {{/datapath_testbench/dut/register/registers[23]} -radix decimal} {{/datapath_testbench/dut/register/registers[22]} -radix decimal} {{/datapath_testbench/dut/register/registers[21]} -radix decimal} {{/datapath_testbench/dut/register/registers[20]} -radix decimal} {{/datapath_testbench/dut/register/registers[19]} -radix decimal} {{/datapath_testbench/dut/register/registers[18]} -radix decimal} {{/datapath_testbench/dut/register/registers[17]} -radix decimal} {{/datapath_testbench/dut/register/registers[16]} -radix decimal} {{/datapath_testbench/dut/register/registers[15]} -radix decimal} {{/datapath_testbench/dut/register/registers[14]} -radix decimal} {{/datapath_testbench/dut/register/registers[13]} -radix decimal} {{/datapath_testbench/dut/register/registers[12]} -radix decimal} {{/datapath_testbench/dut/register/registers[11]} -radix decimal} {{/datapath_testbench/dut/register/registers[10]} -radix decimal} {{/datapath_testbench/dut/register/registers[9]} -radix decimal} {{/datapath_testbench/dut/register/registers[8]} -radix decimal} {{/datapath_testbench/dut/register/registers[7]} -radix decimal} {{/datapath_testbench/dut/register/registers[6]} -radix decimal} {{/datapath_testbench/dut/register/registers[5]} -radix decimal} {{/datapath_testbench/dut/register/registers[4]} -radix decimal} {{/datapath_testbench/dut/register/registers[3]} -radix decimal} {{/datapath_testbench/dut/register/registers[2]} -radix decimal} {{/datapath_testbench/dut/register/registers[1]} -radix decimal} {{/datapath_testbench/dut/register/registers[0]} -radix decimal}} -subitemconfig {{/datapath_testbench/dut/register/registers[31]} {-radix decimal} {/datapath_testbench/dut/register/registers[30]} {-radix decimal} {/datapath_testbench/dut/register/registers[29]} {-radix decimal} {/datapath_testbench/dut/register/registers[28]} {-radix decimal} {/datapath_testbench/dut/register/registers[27]} {-radix decimal} {/datapath_testbench/dut/register/registers[26]} {-radix decimal} {/datapath_testbench/dut/register/registers[25]} {-radix decimal} {/datapath_testbench/dut/register/registers[24]} {-radix decimal} {/datapath_testbench/dut/register/registers[23]} {-radix decimal} {/datapath_testbench/dut/register/registers[22]} {-radix decimal} {/datapath_testbench/dut/register/registers[21]} {-radix decimal} {/datapath_testbench/dut/register/registers[20]} {-radix decimal} {/datapath_testbench/dut/register/registers[19]} {-radix decimal} {/datapath_testbench/dut/register/registers[18]} {-radix decimal} {/datapath_testbench/dut/register/registers[17]} {-radix decimal} {/datapath_testbench/dut/register/registers[16]} {-radix decimal} {/datapath_testbench/dut/register/registers[15]} {-radix decimal} {/datapath_testbench/dut/register/registers[14]} {-radix decimal} {/datapath_testbench/dut/register/registers[13]} {-radix decimal} {/datapath_testbench/dut/register/registers[12]} {-radix decimal} {/datapath_testbench/dut/register/registers[11]} {-radix decimal} {/datapath_testbench/dut/register/registers[10]} {-radix decimal} {/datapath_testbench/dut/register/registers[9]} {-radix decimal} {/datapath_testbench/dut/register/registers[8]} {-radix decimal} {/datapath_testbench/dut/register/registers[7]} {-radix decimal} {/datapath_testbench/dut/register/registers[6]} {-radix decimal} {/datapath_testbench/dut/register/registers[5]} {-radix decimal} {/datapath_testbench/dut/register/registers[4]} {-radix decimal} {/datapath_testbench/dut/register/registers[3]} {-radix decimal} {/datapath_testbench/dut/register/registers[2]} {-radix decimal} {/datapath_testbench/dut/register/registers[1]} {-height 15 -radix decimal} {/datapath_testbench/dut/register/registers[0]} {-height 15 -radix decimal}} /datapath_testbench/dut/register/registers
add wave -noupdate /datapath_testbench/dut/alu_operation/cntrl
add wave -noupdate -radix decimal /datapath_testbench/dut/alu_operation/result
add wave -noupdate /datapath_testbench/dut/alu_operation/A
add wave -noupdate /datapath_testbench/dut/alu_operation/B
add wave -noupdate /datapath_testbench/dut/register/ReadData1
add wave -noupdate /datapath_testbench/dut/register/ReadData2
add wave -noupdate /datapath_testbench/dut/register/ReadRegister1
add wave -noupdate /datapath_testbench/dut/register/ReadRegister2
add wave -noupdate /datapath_testbench/dut/register/WriteData
add wave -noupdate /datapath_testbench/dut/data_memory/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {550503 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1024 ns}
