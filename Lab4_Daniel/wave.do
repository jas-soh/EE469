onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Pipelined_CPU_testbench/dut/clk
add wave -noupdate /Pipelined_CPU_testbench/dut/reset
add wave -noupdate /Pipelined_CPU_testbench/dut/BrTaken
add wave -noupdate /Pipelined_CPU_testbench/dut/negative
add wave -noupdate /Pipelined_CPU_testbench/dut/zero
add wave -noupdate /Pipelined_CPU_testbench/dut/overflow
add wave -noupdate /Pipelined_CPU_testbench/dut/carry_out
add wave -noupdate /Pipelined_CPU_testbench/dut/Flags
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/branch_sum
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/instr_addr_IF
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/instr_addr_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/instruction_IF
add wave -noupdate /Pipelined_CPU_testbench/dut/instruction_RF
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/dataA_RF
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/dataB_RF
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/immVal_RF
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/shift_output_RF
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/dataA_EX
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/dataB_EX
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/immVal_EX
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/shift_output_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/s2/BrTaken
add wave -noupdate /Pipelined_CPU_testbench/dut/ALUSrc_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/memWrite_E_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/MemToReg_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/regWrite_E_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/mem_read_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/setFlag_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/shiftSel_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/ALUSrc_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/memWrite_E_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/MemToReg_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/regWrite_E_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/mem_read_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/setFlag_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/shiftSel_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/regWrite_E_WB
add wave -noupdate /Pipelined_CPU_testbench/dut/forwardOpflags
add wave -noupdate /Pipelined_CPU_testbench/dut/regWrite_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/regWrite_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/readRegB
add wave -noupdate /Pipelined_CPU_testbench/dut/regWrite_WB
add wave -noupdate /Pipelined_CPU_testbench/dut/ALUOp_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/ALUOp_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/ALU_out_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/ALU_out_MEM
add wave -noupdate /Pipelined_CPU_testbench/dut/writeBack_mem
add wave -noupdate /Pipelined_CPU_testbench/dut/WriteData_WB
add wave -noupdate /Pipelined_CPU_testbench/dut/instr_31_to_25_EX
add wave -noupdate /Pipelined_CPU_testbench/dut/instr_31_to_25_RF
add wave -noupdate /Pipelined_CPU_testbench/dut/fOp_A
add wave -noupdate /Pipelined_CPU_testbench/dut/fOp_B
add wave -noupdate /Pipelined_CPU_testbench/dut/memWrite_E_MEM
add wave -noupdate /Pipelined_CPU_testbench/dut/MemToReg_MEM
add wave -noupdate /Pipelined_CPU_testbench/dut/regWrite_E_MEM
add wave -noupdate /Pipelined_CPU_testbench/dut/mem_read_MEM
add wave -noupdate /Pipelined_CPU_testbench/dut/regWrite_MEM
add wave -noupdate /Pipelined_CPU_testbench/dut/mem_Din_MEM
add wave -noupdate /Pipelined_CPU_testbench/dut/s2/regist/registers
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/s4/mem/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {717099 ps} 0}
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
WaveRestoreZoom {506168 ps} {1022264 ps}
