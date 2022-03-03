onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipelined_cpu_testbench/ClockDelay
add wave -noupdate /pipelined_cpu_testbench/reset
add wave -noupdate /pipelined_cpu_testbench/clk
add wave -noupdate /pipelined_cpu_testbench/dut/negFlag
add wave -noupdate -childformat {{{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[18]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[17]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[16]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[15]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[14]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[13]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[12]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[11]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[10]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[9]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[8]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[7]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[6]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[5]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[4]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[3]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[2]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[1]} -radix decimal} {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[0]} -radix decimal}} -subitemconfig {{/pipelined_cpu_testbench/dut/instruction_decode/register/registers[18]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[17]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[16]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[15]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[14]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[13]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[12]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[11]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[10]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[9]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[8]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[7]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[6]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[5]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[4]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[3]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[2]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[1]} {-radix decimal} {/pipelined_cpu_testbench/dut/instruction_decode/register/registers[0]} {-radix decimal}} /pipelined_cpu_testbench/dut/instruction_decode/register/registers
add wave -noupdate /pipelined_cpu_testbench/dut/memory_fetch/data_memory/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3120503 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 353
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
WaveRestoreZoom {1719274 ps} {3298986 ps}
