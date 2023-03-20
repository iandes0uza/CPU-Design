transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/rotate.v}
vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/mux_2_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/logical_ops.v}
vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/gen_regs.v}
vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/encoder_32_5.v}
vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/bus_mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/arithmetic_mult.v}
vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/arithmetic_div.v}
vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/add_sub.v}

vlog -vlog01compat -work work +incdir+C:/Users/ian/Documents/CPU-Design/CPU-System {C:/Users/ian/Documents/CPU-Design/CPU-System/datapath_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  datapath_tb

add wave *
view structure
view signals
run 1000 ns
