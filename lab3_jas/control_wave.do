onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_testbench/instr
add wave -noupdate /control_testbench/branch
add wave -noupdate /control_testbench/zeroFlag
add wave -noupdate /control_testbench/Reg2Loc
add wave -noupdate /control_testbench/ALUSrc
add wave -noupdate /control_testbench/MemToReg
add wave -noupdate /control_testbench/RegWrite
add wave -noupdate /control_testbench/MemWrite
add wave -noupdate /control_testbench/BrTaken
add wave -noupdate /control_testbench/UncondBr
add wave -noupdate /control_testbench/ALUOp
add wave -noupdate /control_testbench/setFlag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
