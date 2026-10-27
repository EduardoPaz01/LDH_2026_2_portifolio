module mult_datapath(
	input  [3:0] a,
	input  [3:0] b,
	output [7:0] m,
	
	// Sinais de controle (vindo da fsm)
	input load,
	input clear,
	
	// Sinais de estado (indo para a fsm)
	output zero
);

	reg [7:0] acc;
	reg [7:0] reg_a;
	reg [7:0] reg_b;
	
	wire [3:0] shift_a;
	wire [3:0] shift_b;
	wire [3:0] sel_a;
	wire [3:0] sel_b;
	
	ripple_carry_adder #(.bits(7)) adder(
		.a(),
		.b(),
		.s()
	);

endmodule 