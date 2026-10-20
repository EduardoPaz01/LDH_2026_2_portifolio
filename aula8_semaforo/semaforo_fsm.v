`define STATE_RED_LOAD 		3'd0
`define STATE_RED 			3'd1
`define STATE_YELLOW_LOAD 	3'd2
`define STATE_YELLOW 		3'd3
`define STATE_GREEN_LOAD	3'd4
`define STATE_GREEN 			3'd5

module semaforo_fsm (
	input			 rst,
	input 		 clk,

	// Sinais de controle indo para o datapagth
	output reg [1:0] sel,
	output reg		 clear,
	
	// Sinais de estado vindo do datapagth
	input			 top,
	
	// Saídas de controle para o dispositivo
	output reg [2:0] lights
);

	reg [2:0] state;
	reg [2:0] next_state;

	// Motor de estados
	always @(posedge clk) begin
		if(rst) state <= `STATE_RED_LOAD;
		else state <= next_state;
	end
	
	// Lógica do próximo estado
	always @(*) begin
		case (state)
			`STATE_RED_LOAD: next_state = `STATE_RED;
			`STATE_RED: next_state = (top) ? `STATE_GREEN_LOAD : `STATE_RED;
			
			`STATE_GREEN_LOAD: next_state = `STATE_GREEN;
			`STATE_GREEN: next_state = (top) ? `STATE_YELLOW_LOAD : `STATE_GREEN;
			
			`STATE_YELLOW_LOAD: next_state = `STATE_YELLOW;
			`STATE_YELLOW: next_state = (top) ? `STATE_RED_LOAD : `STATE_RED;
			
			default: next_state = `STATE_RED_LOAD;
		endcase
	end
	
	// Lógica de saída
	always @(*) begin
		clear = 0;
		case(state)
			`STATE_RED_LOAD: clear = 1;
			`STATE_RED: begin
				lights = 3'b100;
				sel = 2'd0;
			end
			
			`STATE_GREEN_LOAD: clear = 1;
			`STATE_GREEN: begin
				lights = 3'b001;
				sel = 2'd1;
			end
			
			`STATE_YELLOW_LOAD: clear = 1;
			`STATE_YELLOW: begin
				lights = 3'b010;
				sel = 2'd2;
			end
		endcase
	end

endmodule 