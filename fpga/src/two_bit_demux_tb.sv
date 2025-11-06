// two_bit_demux.sv
// testbench file for two_bit_demultiplexer
// george davis gdavis@hmc.edu
// 8/31/2025

//Referenced E85 Lab_2 testbench provided tutorial by david harris to make this file

	`timescale 1ps/1ps //timescale <time_unit>/<time_precision>

module testbench_two_bit_demux; //change to DUT module name
	//input/output variables
	logic		  enable;
	logic   [1:0] control;
	logic 	[31:0] errors;
	//instatiate device to be tested
	two_bit_demux dut(enable, control);

	initial begin
		errors = 0;
		#5;
		enable = 1; #5;
		if(control != 2'b10)begin
			$display("Error: inputs = %b", {enable});
			$display(" outputs = %b", {control});
			errors = errors+1;
		end
		#5;
		enable = 0; #5
		if(control != 2'b01)begin
			$display("Error: inputs = %b", {enable});
			$display(" outputs = %b", {control});
			errors = errors+1;
		end
		#5;
		$display("tests completed with %d errors", errors);
		$stop;

	end

    // //generates clock 
	// always
	// 	begin
	// 		clk <= 1; # 5; clk <= 0; # 5;
	// 	end

	
	// initial
	// 	begin
	// 		$readmemb("two_bit_demux.tv", testvectors);
			
	// 		//Initialize 0 vectors tested and errors
	// 		vectornum = 0;
	// 		errors = 0; 
			
	// 		//Pulse reset to begin test
	// 		reset <= 1; # 22; reset <= 0;
	// 	end

	//   	//Check test vectors at the falling edge of the clock 
	// 	always @(posedge clk)
	// 		begin
	// 			#1;
	// 			//loads test vectors into inputs and expected outputs
	// 			{enable, control_expected} = testvectors[vectornum];
	// 		end
	
    
	// 	always @(negedge clk)
	// 		if(~reset) begin
	// 			//detect error by comparing actual output expected output from testvectors
	// 			if (control != control_expected) begin
	// 				//display input/outputs that generated the error
	// 				$display("Error: inputs = %b", {enable});
	// 				$display(" outputs = %b", {control});
	// 				errors = errors + 1;
	// 			end
	// 			vectornum = vectornum + 1;
	// 			if (testvectors[vectornum] == 14'bX) begin
	// 				$display("%d tests completed with %d errors", vectornum, errors);
	// 				$stop;
	// 			end
	// 		end

endmodule