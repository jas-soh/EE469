# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
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
vlog "./alustim.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
#vsim -voptargs="+acc" -t 1ps -lib work add_subtract_testbench
#vsim -voptargs="+acc" -t 1ps -lib work fullAdder_testbench
#vsim -voptargs="+acc" -t 1ps -lib work AND_func_testbench
#vsim -voptargs="+acc" -t 1ps -lib work OR_func_testbench
#vsim -voptargs="+acc" -t 1ps -lib mux_8_1_testbench
#vsim -voptargs="+acc" -t 1ps -lib alu_testbench
#vsim -voptargs="+acc" -t 1ps -lib flags_testbench
vsim -voptargs="+acc" -t 1ps -lib alustim
#vsim -voptargs="+acc" -t 1ps -lib work XOR_func_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
#do add_subtract_wave.do
#do fullAdder_wave.do
#do AND_func_wave.do
#do OR_func_wave.do
#do mux3_1_wave.do
#do alu_wave.do
#do flags_wave.do
do alustim_wave.do
#do XOR_func_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
