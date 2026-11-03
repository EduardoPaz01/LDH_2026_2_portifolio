module seq_mult(
	input clk,
	input rst,
	
	// Dados
	input  [3:0] a,
	input  [3:0] b,
	output [7:0] m,
	
	// Entrada do usuário
	input start,
	
	// Saída par o usuário
	output done
);
	
	wire load, clear, zero;
	
	mult_fsm fsm (
		.rst(rst),
		.clk(clk),
		// Sinais de controle
		.load(load),
		.clear(clear),
		// Sinais de estado
		.zero(zero),
		// Sinais do usuário
		.start(start),
		.done(done)
	);
	
	mult_datapath dp (
		.clk(clk),
		.a(a),
		.b(b),
		.m(m),
		// Sinais de controle
		.load(load),
		.clear(clear),
		// Sinais de estado
		.zero(zero)
	);

endmodule 