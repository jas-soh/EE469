onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ID_testbench/ClockDelay
add wave -noupdate /ID_testbench/clk
add wave -noupdate /ID_testbench/reset
add wave -noupdate /ID_testbench/instr
add wave -noupdate /ID_testbench/branch
add wave -noupdate /ID_testbench/ALUzeroFlag
add wave -noupdate /ID_testbench/RegWrite_WB
add wave -noupdate /ID_testbench/WriteRegister_WB
add wave -noupdate /ID_testbench/WriteData_WB
add wave -noupdate /ID_testbench/ALUSrc_ID
add wave -noupdate /ID_testbench/MemToReg_ID
add wave -noupdate /ID_testbench/RegWrite_ID
add wave -noupdate /ID_testbench/MemWrite_ID
add wave -noupdate /ID_testbench/BrTaken_ID
add wave -noupdate /ID_testbench/ALUOp_ID
add wave -noupdate /ID_testbench/read_enable_ID
add wave -noupdate /ID_testbench/ImmSize_out
add wave -noupdate /ID_testbench/Da
add wave -noupdate /ID_testbench/Db
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {52847 ps} 0}
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
WaveRestoreZoom {42300 ps} {58300 ps}
