// lab2_HSOSC_tb.sv
// testbench file for the top level module of the keypad decoder lab
// George Davis
// gdavis@hmc.edu
// 9/15/25

`timescale 1 ns/1 ns

module lab2_HSOSC_tb;

    logic   [3:0]   sA;
    logic   [3:0]   sB;
    logic   [1:0]   control;
    logic   [6:0]   seg;
    logic	[4:0]	led;

    logic [31:0] errors;

    lab2_gd dut(sA, sB, control, seg, led);

    initial
        begin
            errors = 0;


          #134988

            assert(dut.clk == 1) else begin
                $error("ERROR: HSOSC not turning on time: %0t", $time); 
                errors = errors + 1;
            end
            $error("Tests completed with %b errors", errors);
            $stop;
        end

endmodule