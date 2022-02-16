# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./control.sv"
vlog "./single_cycle_cpu.sv"
vlog "./datapath.sv"
vlog "./ALU.sv"
vlog "./add_subtract.sv"
vlog "./fullAdder.sv"
vlog "./mux.sv"
vlog "./mux8_1.sv"
vlog "./AND_func.sv"
vlog "./OR_func.sv"
vlog "./xor_func.sv"
vlog "./flags.sv"
vlog "./NOR_func.sv"
vlog "./register.sv"
vlog "./regfile.sv"
vlog "./decoder2_4.sv"
vlog "./decoder3_8.sv"
vlog "./math.sv"
vlog "./mux_32_1.sv"
vlog "./mux_64x32_1.sv"
vlog "./datamem.sv"
vlog "./program_counter.sv"
vlog "./instructmem.sv"
vlog "./updateFlag.sv"
vlog "./regstim.sv"



# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
#vsim -voptargs="+acc" -t 1ps -lib work control_testbench
#vsim -voptargs="+acc" -t 1ps -lib work datapath_testbench
#vsim -voptargs="+acc" -t 1ps -lib work program_counter_testbench
#vsim -voptargs="+acc" -t 1ps -lib work instructmem_testbench
vsim -voptargs="+acc" -t 1ps -lib work single_cycle_cpu_testbench
#vsim -voptargs="+acc" -t 1ps -lib work updateFlag_testbench
#vsim -voptargs="+acc" -t 1ps -lib work datamem_testbench
#vsim -voptargs="+acc" -t 1ps -lib work regstim
#vsim -voptargs="+acc" -t 1ps -lib work regfile_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
#do control_wave.do
#do datapath_wave.do
#do program_counter_wave.do
#do instructmem_wave.do
do single_cycle_cpu_wave.do
#do updateFlag_wave.do
#do datamem_wave.do
#do regstim_wave.do
#do regfile_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
