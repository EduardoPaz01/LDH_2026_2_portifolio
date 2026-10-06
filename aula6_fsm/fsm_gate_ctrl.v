`define STATE_CLOSED  2'b00
`define STATE_CLOSING 2'b01
`define STATE_OPEN    2'b10
`define STATE_OPENING 2'b11

module fsm_gate_ctrl(
	input rst,
	input clk,
	
	// Sinais de controle
	input user_button,
	input start_stop,
	input end_stop,
	
	//Saída
	output motor_power,
	output motor_directon
);

	reg [1:0] state;// [closed, closing, open, opening]
	reg [1:0] nextstate;
	
	//Motor de estados
	
	//always @(posedge clk or posedge rst) begin
	//	if(rst) begin // reset assíncrono
	//		state <= STATE_CLOSED;
	//	end else begin
	//		state <= nextstate;
	//	end
	//end
	always @(posedge clk) begin
		if(rst) begin // reset síncrono
			state <= `STATE_CLOSED; // "<=" transição não bloqueante, só sofre definição no final do ciclo, não há multiplas definições
		end else begin
			state <= nextstate;
		end
	end
	
	
	//Lógica de transição (bloco assíncrono)
	
	always @(*) begin
		case(state)
			// CLOSED
			`STATE_CLOSED: begin // "=" transição bloqueante
				if(user_button == 1'b0) nextstate = `STATE_CLOSED; 
				else                    nextstate = `STATE_OPENING;
			end
			// OPENING
			`STATE_OPENING: begin
				if(end_stop == 1'b0) nextstate = `STATE_OPENING;
				else                 nextstate = `STATE_OPEN;
			end
			//OPEN
			`STATE_OPEN: begin
				if(user_button == 1'b0) nextstate = `STATE_OPEN;
				else                    nextstate = `STATE_OPENING;
			end
			// CLOSING
			`STATE_CLOSING: begin
				if(start_stop == 1'b0) nextstate = `STATE_CLOSING;
				else                   nextstate = `STATE_CLOSED;
			end			
		endcase
	end
	
	
	//Lógica de saída (bloco assíncrono)
	
	assign motor_power = 
		(state == `STATE_CLOSING || state == `STATE_OPENING) ? 
		1b'1: 1b'0;
		
	assign motor_direction = 
		(state == `STATE_OPENING) ? 
		1b'1: 1b'0;

endmodule
