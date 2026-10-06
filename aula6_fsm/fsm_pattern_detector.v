`define S0 0
`define S1 1
`define S2 2
`define S3 3
`define S4 4

module fsm_pattern_detector (
	input rst,
	input clk,
	
	// Sinais de controle
	input in_bit,
	
	// Sinal de saída
	output match
);

	reg [2:0] state;// [S0, S1, S2, S3, S4]
	reg [2:0] nextstate;
	
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
			state <= `S0; // "<=" transição não bloqueante, só sofre definição no final do ciclo, não há multiplas definições
		end else begin
			state <= nextstate;
		end
	end
	
	
	//Lógica de transição (bloco assíncrono)
	
	always @(*) begin
		case(state)
			`S0: begin
				if(in_bit == 1'b0) nextstate = `S0; 
				else               nextstate = `S1;
			end
			
			`S1: begin
				if(in_bit == 1'b0) nextstate = `S0; 
				else               nextstate = `S2;
			end
			
			`S2: begin
				if(in_bit == 1'b0) nextstate = `S3; 
				else               nextstate = `S1;
			end
			
			`S3: begin
				if(in_bit == 1'b0) nextstate = `S0; 
				else               nextstate = `S4;
			end
			
			`S4: begin
				if(in_bit == 1'b0) nextstate = `S4; 
				else               nextstate = `S4;
			end
					
		endcase
	end
	
	
	//Lógica de saída (bloco assíncrono)
	
	assign match = 
		(state == `S4) ? 
		1'b1: 1'b0;

endmodule
