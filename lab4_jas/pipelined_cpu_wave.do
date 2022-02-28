onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipelined_cpu_testbench/ClockDelay
add wave -noupdate /pipelined_cpu_testbench/reset
add wave -noupdate /pipelined_cpu_testbench/clk
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_decode/instr_ID
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_decode/register/ReadData2
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_decode/instr_addr_ID
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_fetch/branchVal
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_fetch/BrTaken
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_fetch/next_instr_addr
add wave -noupdate /pipelined_cpu_testbench/dut/fwd/forwardA
add wave -noupdate /pipelined_cpu_testbench/dut/fwd/forwardB
add wave -noupdate -childformat {{{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[6]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[5]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[4]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[3]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[2]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[1]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[0]} -radix decimal}} -subitemconfig {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[6]} {-height 15 -radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[5]} {-height 15 -radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[4]} {-height 15 -radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[3]} {-height 15 -radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[2]} {-height 15 -radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[1]} {-height 15 -radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[0]} {-height 15 -radix decimal}} /pipelined_cpu_testbench/dut/instruction_decode/register/registers
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_decode/register/ReadData1
add wave -noupdate /pipelined_cpu_testbench/dut/fwd/Aa
add wave -noupdate /pipelined_cpu_testbench/dut/fwd/Ab
add wave -noupdate /pipelined_cpu_testbench/dut/fwd/RegWrite_MEM
add wave -noupdate /pipelined_cpu_testbench/dut/fwd/WriteRegister_MEM
add wave -noupdate /pipelined_cpu_testbench/dut/fwd/RegWrite_EX
add wave -noupdate /pipelined_cpu_testbench/dut/fwd/WriteRegister_EX
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_decode/Da_ID
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_decode/Db_ID
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_decode/WriteData_WB
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_decode/WriteData_EX
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_decode/WriteData_MEM
add wave -noupdate /pipelined_cpu_testbench/dut/execute/ALUzeroFlag
add wave -noupdate /pipelined_cpu_testbench/dut/instruction_decode/WriteRegister_ID
add wave -noupdate /pipelined_cpu_testbench/dut/accelerate/accel_zero
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {202600 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 239
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
WaveRestoreZoom {0 ps} {428371 ps}
