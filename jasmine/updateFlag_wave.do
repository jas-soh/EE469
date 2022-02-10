onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /single_cycle_cpu_testbench/dut/ClockDelay
add wave -noupdate /single_cycle_cpu_testbench/dut/clk
add wave -noupdate /single_cycle_cpu_testbench/dut/reset
add wave -noupdate /single_cycle_cpu_testbench/dut/instr
add wave -noupdate /single_cycle_cpu_testbench/dut/branch
add wave -noupdate /single_cycle_cpu_testbench/dut/zeroFlag
add wave -noupdate /single_cycle_cpu_testbench/dut/Reg2Loc
add wave -noupdate /single_cycle_cpu_testbench/dut/ALUSrc
add wave -noupdate /single_cycle_cpu_testbench/dut/MemToReg
add wave -noupdate /single_cycle_cpu_testbench/dut/RegWrite
add wave -noupdate /single_cycle_cpu_testbench/dut/MemWrite
add wave -noupdate /single_cycle_cpu_testbench/dut/BrTaken
add wave -noupdate /single_cycle_cpu_testbench/dut/UncondBr
add wave -noupdate /single_cycle_cpu_testbench/dut/ALUOp
add wave -noupdate /single_cycle_cpu_testbench/dut/setFlag
add wave -noupdate /single_cycle_cpu_testbench/dut/shiftSel
add wave -noupdate /single_cycle_cpu_testbench/dut/immSize
add wave -noupdate /single_cycle_cpu_testbench/dut/instr_addr
add wave -noupdate /single_cycle_cpu_testbench/dut/shamt
add wave -noupdate /single_cycle_cpu_testbench/dut/ALUzeroFlag
add wave -noupdate /single_cycle_cpu_testbench/dut/negFlag
add wave -noupdate /single_cycle_cpu_testbench/dut/ovFlag
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
