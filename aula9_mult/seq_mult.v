module seq_mult(
	input clk,
	input rst,
	
	input  [3:0] a,
	input  [3:0] b,
	
	output [7:0] m
);
	
	mult_fsm fsm (
		.rst(rst),
		.clk(clk),
		// Sinais de controle
		
	);
	
	mult_datapath dp (
		.a(a),
		.b(b),
		.m(m),
		// Sinais de controle
	);

endmodule 