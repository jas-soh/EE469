onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /EX_MEM_reg_testbench/ClockDelay
add wave -noupdate /EX_MEM_reg_testbench/clk
add wave -noupdate /EX_MEM_reg_testbench/reset
add wave -noupdate /EX_MEM_reg_testbench/MemWrite_EX
add wave -noupdate /EX_MEM_reg_testbench/MemToReg_EX
add wave -noupdate /EX_MEM_reg_testbench/RegWrite_EX
add wave -noupdate /EX_MEM_reg_testbench/ALU_out_EX
add wave -noupdate /EX_MEM_reg_testbench/WriteRegister_EX
add wave -noupdate /EX_MEM_reg_testbench/Din_EX
add wave -noupdate /EX_MEM_reg_testbench/MemWrite_MEM
add wave -noupdate /EX_MEM_reg_testbench/MemToReg_MEM
add wave -noupdate /EX_MEM_reg_testbench/RegWrite_MEM
add wave -noupdate /EX_MEM_reg_testbench/ALU_out_MEM
add wave -noupdate /EX_MEM_reg_testbench/WriteRegister_MEM
add wave -noupdate /EX_MEM_reg_testbench/Din_MEM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {1 ns}
