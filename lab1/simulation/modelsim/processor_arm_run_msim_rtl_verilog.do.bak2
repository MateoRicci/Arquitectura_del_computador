transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/sl2.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/mux2.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/execute.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/alu.sv}
vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/modulos/adder.sv}

vlog -sv -work work +incdir+Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/test-benches {Z:/Mateo/Documents/GitHub/lab1-adc2024-g31/test-benches/execute_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  execute_tb

add wave *
view structure
view signals
run -all
