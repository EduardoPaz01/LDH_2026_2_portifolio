`define STATE_CLOSED     3'b000
`define STATE_OPENING    3'b001
`define STATE_HALF_OPEN  3'b010
`define STATE_OPEN       3'b011
`define STATE_CLOSING    2'b100
`define STATE_HALF_CLOSE 2'b101

module fsm_gate_ctrl(
	input rst,
	input clk,
	
	// Sinais de controle
	input user_button,
	input start_stop,
	input end_stop,
	
	//Saída
	output motor_power,
	output motor_direction
);

	reg [2:0] state;
	reg [2:0] nextstate;
	
	//Motor de estados
	always @(posedge clk) begin
		if(rst) begin // reset síncrono
			state <= `STATE_CLOSED; // "<=" transição não bloqueante, só sofre definição no final do ciclo, não há multiplas definições
		end else begin
			state <= nextstate;
		end
	end
	
	
	//Lógica de transição (bloco assíncrono)
	 always @(*) begin
        nextstate = state;

        case (state)
            // Portão fechado
            `STATE_CLOSED: begin
                if (user_button)
                    nextstate = `STATE_OPENING;
            end

            // Portão abrindo
            `STATE_OPENING: begin
                if (user_button)
                    nextstate = `STATE_CLOSING;
                else if (end_stop)
                    nextstate = `STATE_OPEN;
                else if (start_stop)
                    nextstate = `STATE_HALF_OPEN;
            end

            // Portão parcialmente aberto
            `STATE_HALF_OPEN: begin
                if (user_button)
                    nextstate = `STATE_CLOSING;
                else if (end_stop)
                    nextstate = `STATE_OPEN;
            end

            // Portão totalmente aberto
            `STATE_OPEN: begin
                if (user_button)
                    nextstate = `STATE_CLOSING;
            end

            // Portão fechando
            `STATE_CLOSING: begin
                if (user_button)
                    nextstate = `STATE_OPENING;
                else if (start_stop)
                    nextstate = `STATE_CLOSED;
                else if (end_stop)
                    nextstate = `STATE_HALF_CLOSE;
            end

            // Portão parcialmente fechado
            `STATE_HALF_CLOSE: begin
                if (user_button)
                    nextstate = `STATE_OPENING;
                else if (start_stop)
                    nextstate = `STATE_CLOSED;
            end

            // Recuperação de estado inválido
            default: nextstate = `STATE_CLOSED;

        endcase
    end
	
	
	//Lógica de saída (bloco assíncrono)
	assign motor_power = (state == `STATE_CLOSING || state == `STATE_OPENING);
	assign motor_direction = (state == `STATE_OPENING);

endmodule
