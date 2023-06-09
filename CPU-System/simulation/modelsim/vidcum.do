onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_tb/PCout
add wave -noupdate /datapath_tb/ZHighout
add wave -noupdate /datapath_tb/ZLowout
add wave -noupdate /datapath_tb/ZHighIn
add wave -noupdate /datapath_tb/ZLowIn
add wave -noupdate /datapath_tb/MDRout
add wave -noupdate /datapath_tb/MARin
add wave -noupdate /datapath_tb/PCin
add wave -noupdate /datapath_tb/MDRin
add wave -noupdate /datapath_tb/IRin
add wave -noupdate /datapath_tb/Yin
add wave -noupdate /datapath_tb/Yout
add wave -noupdate /datapath_tb/IncPC
add wave -noupdate /datapath_tb/Read
add wave -noupdate /datapath_tb/opcode
add wave -noupdate /datapath_tb/Clock
add wave -noupdate /datapath_tb/Clear
add wave -noupdate /datapath_tb/CONin
add wave -noupdate /datapath_tb/RAMin
add wave -noupdate /datapath_tb/Rin
add wave -noupdate /datapath_tb/Rout
add wave -noupdate /datapath_tb/REGin
add wave -noupdate /datapath_tb/REGout
add wave -noupdate /datapath_tb/GRA
add wave -noupdate /datapath_tb/GRB
add wave -noupdate /datapath_tb/GRC
add wave -noupdate /datapath_tb/BAout
add wave -noupdate /datapath_tb/HIin
add wave -noupdate /datapath_tb/LOin
add wave -noupdate /datapath_tb/HIout
add wave -noupdate /datapath_tb/LOout
add wave -noupdate /datapath_tb/Cout
add wave -noupdate /datapath_tb/InPortOut
add wave -noupdate /datapath_tb/InPortIn
add wave -noupdate /datapath_tb/OutPortIn
add wave -noupdate /datapath_tb/Mdatain
add wave -noupdate /datapath_tb/InPort_data
add wave -noupdate /datapath_tb/OutPort_data
add wave -noupdate /datapath_tb/bus
add wave -noupdate /datapath_tb/Present_state
add wave -noupdate /datapath_tb/DUT/r2/q
add wave -noupdate /datapath_tb/DUT/r2/d
add wave -noupdate /datapath_tb/DUT/r2/en
add wave -noupdate /datapath_tb/DUT/r2/clr
add wave -noupdate /datapath_tb/DUT/r2/clk
add wave -noupdate /datapath_tb/DUT/pc/pc_out
add wave -noupdate /datapath_tb/DUT/pc/pc_in
add wave -noupdate /datapath_tb/DUT/pc/pc_inc
add wave -noupdate /datapath_tb/DUT/pc/enable
add wave -noupdate /datapath_tb/DUT/pc/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {999110 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {999050 ps} {1000050 ps}
