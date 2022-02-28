onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /EX_testbench/dut/alu_operation/A
add wave -noupdate /EX_testbench/dut/alu_operation/B
add wave -noupdate /EX_testbench/dut/alu_operation/cntrl
add wave -noupdate /EX_testbench/dut/alu_operation/result
add wave -noupdate /EX_testbench/dut/alu_operation/negative
add wave -noupdate /EX_testbench/dut/alu_operation/zero
add wave -noupdate /EX_testbench/dut/alu_operation/overflow
add wave -noupdate /EX_testbench/dut/alu_operation/carry_out_flag
add wave -noupdate /EX_testbench/dut/alu_operation/subtract_signal
add wave -noupdate /EX_testbench/dut/alu_operation/sum
add wave -noupdate /EX_testbench/dut/alu_operation/carry_out
add wave -noupdate /EX_testbench/dut/alu_operation/and_result
add wave -noupdate /EX_testbench/dut/alu_operation/or_result
add wave -noupdate /EX_testbench/dut/alu_operation/xor_result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5736 ps} 0}
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
WaveRestoreZoom {4 ns} {8 ns}
