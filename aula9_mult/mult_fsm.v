`define STATE_IDLE 2'd0
`define STATE_OP   2'd1
`define STATE_DONE 2'd2

module mult_fsm(
	input rst,
	input clk,
	
	// Sinais de estado (vindo o datapath)
	input zero,
	
	// Sinais de entrada do usuário
	input start,
	
	// Sinais de controle (indo para o datapath)
	output load,
	output clear,
	
	// Sinais de saída para o usuário
	output done
);

	reg [1:0] state;
	reg [1:0] next_state;

	// Motor de estados
	always @(posedge clk) begin
		if(rst) state <=`STATE_IDLE;
		else state <= next_state;
	end
	
	// Lógica do próximo estado
	always @(*) begin
		case (state)	
			`STATE_IDLE: next_state = (start) ? (`STATE_OP)   : (`STATE_IDLE);
			`STATE_OP:   next_state = (zero)  ? (`STATE_DONE) : (`STATE_OP);
			`STATE_DONE: next_state = (`STATE_IDLE);
			default:     next_state = (`STATE_IDLE);
		endcase
	end
	
	// Sinais de saída
	 assign load  = (state == `STATE_IDLE);
    assign clear = (state == `STATE_IDLE);
    assign done  = (state == `STATE_DONE);

endmodule 