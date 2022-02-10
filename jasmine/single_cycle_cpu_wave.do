onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /single_cycle_cpu_testbench/ClockDelay
add wave -noupdate /single_cycle_cpu_testbench/clk
add wave -noupdate /single_cycle_cpu_testbench/reset
add wave -noupdate -radix binary /single_cycle_cpu_testbench/dut/cntrl/instr
add wave -noupdate /single_cycle_cpu_testbench/dut/pc/instr_addr
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/ALUOp
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/ALU_out
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/Da
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/Db
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/Dw
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/Reg2Loc_out
add wave -noupdate /single_cycle_cpu_testbench/dut/cntrl/branch
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/register/ReadRegister1
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/register/ReadRegister2
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/register/ReadData1
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/register/ReadData2
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/alu_operation/A
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/alu_operation/B
add wave -noupdate -childformat {{{/single_cycle_cpu_testbench/dut/dp/register/registers[7]} -radix decimal} {{/single_cycle_cpu_testbench/dut/dp/register/registers[6]} -radix decimal} {{/single_cycle_cpu_testbench/dut/dp/register/registers[5]} -radix decimal} {{/single_cycle_cpu_testbench/dut/dp/register/registers[4]} -radix decimal} {{/single_cycle_cpu_testbench/dut/dp/register/registers[3]} -radix decimal} {{/single_cycle_cpu_testbench/dut/dp/register/registers[2]} -radix decimal} {{/single_cycle_cpu_testbench/dut/dp/register/registers[1]} -radix decimal} {{/single_cycle_cpu_testbench/dut/dp/register/registers[0]} -radix decimal}} -expand -subitemconfig {{/single_cycle_cpu_testbench/dut/dp/register/registers[7]} {-height 15 -radix decimal} {/single_cycle_cpu_testbench/dut/dp/register/registers[6]} {-height 15 -radix decimal} {/single_cycle_cpu_testbench/dut/dp/register/registers[5]} {-height 15 -radix decimal} {/single_cycle_cpu_testbench/dut/dp/register/registers[4]} {-height 15 -radix decimal} {/single_cycle_cpu_testbench/dut/dp/register/registers[3]} {-height 15 -radix decimal} {/single_cycle_cpu_testbench/dut/dp/register/registers[2]} {-height 15 -radix decimal} {/single_cycle_cpu_testbench/dut/dp/register/registers[1]} {-height 15 -radix decimal} {/single_cycle_cpu_testbench/dut/dp/register/registers[0]} {-height 15 -radix decimal}} /single_cycle_cpu_testbench/dut/dp/register/registers
add wave -noupdate /single_cycle_cpu_testbench/dut/dp/data_memory/mem
add wave -noupdate /single_cycle_cpu_testbench/dut/pc/BrTaken
add wave -noupdate /single_cycle_cpu_testbench/dut/pc/addr
add wave -noupdate /single_cycle_cpu_testbench/dut/pc/sum_PCandImm
add wave -noupdate /single_cycle_cpu_testbench/dut/cntrl/UncondBr
add wave -noupdate /single_cycle_cpu_testbench/dut/update/zeroFlag
add wave -noupdate /single_cycle_cpu_testbench/dut/update/negFlag
add wave -noupdate /single_cycle_cpu_testbench/dut/update/ovFlag
add wave -noupdate /single_cycle_cpu_testbench/dut/update/branch
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {37187 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 281
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
WaveRestoreZoom {25145 ps} {75435 ps}
