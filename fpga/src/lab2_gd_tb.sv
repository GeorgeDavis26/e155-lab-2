// lab2_gd_tb.sv
// test bench file for top level module for lab 2 project
// george davis gdavis@hmc.edu
// 8/31/2025

//Referenced E85 Lab_2 testbench provided tutorial by david harris to make this file

	`timescale 1ps/1ps //timescale <time_unit>/<time_precision>

module lab2_gd_tb;
	logic	clk;
	logic	reset;
	
	//input/output variables
	logic	[3:0] sA, sB;
    logic   [1:0] control, control_expected;
	logic   [6:0] seg, seg_expected;
	logic	[4:0] led;

	
	//instatiate device to be tested
	top dut(sA, sB, control, seg, led);

	initial

endmodule 