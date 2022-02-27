# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./mux2_1.sv"
vlog "./mux8_1.sv"
vlog "./mux4_1.sv"
vlog "./mux3_1.sv"
vlog "./mux_32_1.sv"
vlog "./mux_64x32_1.sv"
vlog "./decoder3_8.sv"
vlog "./decoder2_4.sv"
vlog "./math.sv"
vlog "./register.sv"
vlog "./regfile.sv"
vlog "./ALU_1b.sv"
vlog "./alu.sv"
vlog "./control.sv"
vlog "./add_width.sv"
vlog "./datamem.sv"
vlog "./add_width.sv"
vlog "./fullAdder.sv"
vlog "./instructmem.sv"
vlog "./datamem.sv"
vlog "./Pipelined_CPU.sv"
vlog "./RF.sv"
vlog "./IF.sv"
vlog "./EX.sv"
vlog "./MEM.sv"
vlog "./updateFlags.sv"
vlog "./shift2Left.sv"
vlog "./forwarding_unit.sv"
vlog "./IF_RF_reg.sv"
vlog "./RF_EX_reg.sv"
vlog "./EX_MEM_reg.sv"
vlog "./MEM_WB_reg.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
#vsim -voptargs="+acc" -t 1ps -lib work dataPath_testbench
#vsim -voptargs="+acc" -t 1ps -lib work singCycle_CPU_testbench
#vsim -voptargs="+acc" -t 1ps -lib work control_testbench
#vsim -voptargs="+acc" -t 1ps -lib work dataPath_testbench
#vsim -voptargs="+acc" -t 1ps -lib work alustim
vsim -voptargs="+acc" -t 1ps -lib work Pipelined_CPU_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
#do control_wave.do
do Pipelined_CPU_wave.do
#do alustim_wave.do
#do dataPath_wave.do
#do IF_wave.do
# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
