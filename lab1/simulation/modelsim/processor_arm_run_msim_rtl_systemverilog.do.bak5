transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/sl2.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/signext.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/regfile.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/mux2.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/maindec.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/imem.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/flopr.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/fetch.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/execute.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/alu.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/adder.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/writeback.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/processor_arm.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/memory.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/decode.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/datapath.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/controller.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/aludec.sv}
vcom -2008 -work work {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/dmem.vhd}

vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/test-benches {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/test-benches/processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all
