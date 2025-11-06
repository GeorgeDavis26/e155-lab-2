// swtich_mux_tb.sv
// testbench file for the switch_encoder
// george davis gdavis@hmc.edu
// 8/31/2025

//Referenced E85 Lab_2 testbench provided tutorial by david harris to make this file

	`timescale 1ps/1ps //timescale <time_unit>/<time_precision>

module switch_mux_tb; 
	
	//input/output variables
    logic           enable;
	logic	[3:0]   sA, sB;
	logic   [3:0]   s;

	int i, j;
	//32 bit vectornum indicates the number of test vectors applied
	//32 bit errors indicates number of errros found
	logic	[31:0] errors;
	
	//instatiate device to be tested
	switch_mux dut(enable, sA, sB, s); 

	initial begin
		errors = 0;
		#5;
		for (int i = 0; i < 16; i++)begin
			for(int j = 0; j < 16; j++)begin
				sA = i;
				sB = j;
				#5;
				enable = 0;
				#5;
				if(s != sA) begin
					$error("Error: inputs = %b", {sA, sB}); 
					$error(" outputs = %b", {s});
					errors = errors + 1;
				end
				#5;
				enable = 1;
				#5;
				if(s != sB)  begin
					$error("Error: inputs = %b", {sA, sB}); 
					$error(" outputs = %b", {s});
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