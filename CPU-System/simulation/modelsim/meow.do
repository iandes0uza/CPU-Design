onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /p3_tb/data_in
add wave -noupdate /p3_tb/data_out
add wave -noupdate /p3_tb/bus
add wave -noupdate /p3_tb/opcode
add wave -noupdate /p3_tb/clk
add wave -noupdate /p3_tb/rst
add wave -noupdate /p3_tb/stp
add wave -noupdate /p3_tb/DUT/ir/q
add wave -noupdate /p3_tb/DUT/ir/d
add wave -noupdate /p3_tb/DUT/ir/en
add wave -noupdate /p3_tb/DUT/ir/clr
add wave -noupdate /p3_tb/DUT/ir/clk
add wave -noupdate -radix hexadecimal /p3_tb/DUT/pc/pc_out
add wave -noupdate /p3_tb/DUT/pc/pc_in
add wave -noupdate /p3_tb/DUT/pc/pc_inc
add wave -noupdate /p3_tb/DUT/pc/enable
add wave -noupdate /p3_tb/DUT/pc/clk
add wave -noupdate /p3_tb/DUT/ram_connection/ram_out
add wave -noupdate /p3_tb/DUT/ram_connection/ram_in
add wave -noupdate /p3_tb/DUT/ram_connection/addr
add wave -noupdate /p3_tb/DUT/ram_connection/en
add wave -noupdate /p3_tb/DUT/ram_connection/clk
add wave -noupdate -radix hexadecimal /p3_tb/DUT/ram_connection/ram_contents
add wave -noupdate /p3_tb/DUT/ram_connection/addr_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16776860 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 160
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {101528926 ps}
