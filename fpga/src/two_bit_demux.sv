// two_bit_demux.sv
// de-multiplexer module that takes a single multiplexed enable signal and drives two output pins depending on an enable cycle
// output[1] is on if enable is high, output[0] is on if enable is low
// 9/4/2025

module two_bit_demux( 
    input   logic           enable,
    output  logic   [1:0]   control
);

	enable ? (assign control[1] = 1 & assign control[0] = 0) : (assign control[1] = 0 & assign control[0] = 1);


endmodule