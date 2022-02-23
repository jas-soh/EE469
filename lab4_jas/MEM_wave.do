onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MEM_testbench/ClockDelay
add wave -noupdate /MEM_testbench/clk
add wave -noupdate /MEM_testbench/ALU_out_MEM
add wave -noupdate /MEM_testbench/Db_MEM
add wave -noupdate /MEM_testbench/MemWrite_MEM
add wave -noupdate /MEM_testbench/read_enable_MEM
add wave -noupdate /MEM_testbench/MemToReg_out_MEM
add wave -noupdate /MEM_testbench/MemToReg_MEM
add wave -noupdate /MEM_testbench/dut/data_memory/address
add wave -noupdate /MEM_testbench/dut/data_memory/write_enable
add wave -noupdate /MEM_testbench/dut/data_memory/read_enable
add wave -noupdate /MEM_testbench/dut/data_memory/write_data
add wave -noupdate /MEM_testbench/dut/data_memory/clk
add wave -noupdate /MEM_testbench/dut/data_memory/xfer_size
add wave -noupdate /MEM_testbench/dut/data_memory/read_data
add wave -noupdate /MEM_testbench/dut/data_memory/mem
add wave -noupdate /MEM_testbench/dut/data_memory/aligned_address
add wave -noupdate /MEM_testbench/dut/data_memory/i
add wave -noupdate /MEM_testbench/dut/data_memory/j
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6532 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {34496 ps}
