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
	logic	[4:0] led, led_expecter;

	
	//instatiate device to be tested
	lab2_gd dut(sA, sB, control, seg, led);
	
    task check_control(
        input [1:0] exp_control,
        input string msg
        );
        #1;
        assert (control == exp_control)
            $display("PASSED!: %s -- got control=%h expected control=%h at time %0t.", msg, control, exp_control, $time);
        else
            $error("FAILED!: %s -- got control=%h expected control=%h at time %0t.", msg, control, exp_control, $time);
        #1;
    endtask

    task check_seg(
        input [6:0] exp_seg,
        input string msg
        );
        #1;
        assert (seg == exp_seg)
            $display("PASSED!: %s -- got seg=%h expected seg=%h at time %0t.", msg, seg, exp_seg, $time);
        else
            $error("FAILED!: %s -- got seg=%h expected seg=%h at time %0t.", msg, seg, exp_seg, $time);
        #1;
    endtask

    task check_led(
        input [4:0] exp_led,
        input string msg
        );
        #1;
        assert (led == exp_led)
            $display("PASSED!: %s -- got led=%h expected led=%h time %0t.", msg, led, exp_led, $time);
        else
            $error("FAILED!: %s -- got led=%h expected led=%h time %0t.", msg, led, exp_led, $time);
        #1;
    endtask

    always begin
        clk <= 1; #5;
        clk <= 0; #5;
    end

	initial 
        begin
		#100000 //wait for HSOSC to turn on
		
		//check a few cases to test connectivity
		//all cases covered in submodules
		//clock period is 10 ns or 10000 ps
		sA = 4'b0101; //seg A = 5
		sB = 4'b0011; //seg B = 3
		#1;
		wait(control == 2'b01);
		check_control(2'b01, "Seg A");
		check_seg(7'b0010010, "Seg A");
		#1;
		wait(control == 2'b10);
		check_control(2'b10, "Seg B");
		check_seg(7'b0110000, "Seg B");
		#1;
		wait(led == 5'b01000);
		check_led(5'b01000, "LED Adder");
		end
    

    // add a timeout
    // initial begin
    //     #500000; // wait a long time
    //     $error("Simulation did not complete in time.");
    //     $stop;
    // end
endmodule