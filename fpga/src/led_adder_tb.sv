// seven_seg_disp_tb.sv
// led_adder testbench file 
// george davis gdavis@hmc.edu
// 8/31/2025

//Referenced E85 Lab_2 testbench provided tutorial by david harris to make this file

	`timescale 1ps/1ps //timescale <time_unit>/<time_precision>

module testbench_led_adder;
	
	//input/output variables
	logic	[3:0] sA, sB;  
	logic   [4:0] led, led_expected;
	int i, j;


	//32 bit vectornum indicates the number of test vectors applied
	//32 bit errors indicates number of errros found
	logic [31:0]	errors;
	
	//instatiate device to be tested
	led_adder dut(sA, sB, led);

	initial begin
		errors = 0;
		for (int i = 0; i < 16; i++)begin
			for (int j = 0; j < 16; j++)begin
				sA = i;
				sB = j;
				led_expected = i + j;
				#5;
				if (led != led_expected) begin
					//display input/outputs that generated the error
					$display("Error: inputs = %d, %d", sA, sB);
					$display(" outputs = %d", led);
					errors = errors + 1;
				end	
				#1;
				if(sA == 15 && sB == 15)begin
					$error("%d tests completed with %d errors", (i*j), errors);
					$stop;
				end
				#1;
			end
		end
	end
endmodule