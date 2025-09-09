// lab2_gd.sv
// top level module for the lab 2 dual seven segment display functionality in System Verilog
// george davis gdavis@hmc.edu
// 9/4/2025

module top (
	input	logic			clk, reset,
	input	logic   [3:0]   sA,
    input   logic   [3:0]   sB,
    output  logic   [1:0]   control
	output	logic   [6:0]   seg,
	output	logic	[4:0]	led
);

    //creating enable, multiplexed wire s, along with the counting variable used in the divider
	logic	        enable;
    logic   [3:0]   s;
	logic	[16:0]	counter = 0;

		 
	// Internal 48MHz high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Simple clock divider down to 60 Hz from 12MHz pin 41
	always_ff @(posedge clk)
		begin
			if(reset) counter = 0; 
			else if(counter == 'd100000) begin
				enable  = ~enable;	//flip enable
				counter = 0;		//reset counter
				end
			else counter = counter + 1;
		end
	
	// Mutiplexer to control switch input
	switch_mux	switch_mux(enable, sA, sB, s);

	// De-Multiplexer to control the pnp transitors connected to the common anode of each display
	two_bit_demux	two_bit_demux(enable, control);

	// Seven segment display encoder with the multiplexed signals
    seven_seg_disp  seven_seg_disp(s, seg);

	// Five bit adder 
	led_adder led_adder(sA, sB, led);

endmodule