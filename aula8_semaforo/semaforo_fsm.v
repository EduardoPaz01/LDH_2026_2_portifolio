`define STATE_RED_LOAD 		3'd0
`define STATE_RED 			3'd1
`define STATE_YELLOW_LOAD 	3'd2
`define STATE_YELLOW 		3'd3
`define STATE_GREEN_LOAD	3'd4
`define STATE_GREEN 			3'd5

module semaforo_fsm (
    input wire rst,
    input wire clk,

	 // Sinais de controle indo para o datapagth
    output reg [1:0] sel,
    output reg clear,

	 // Sinais de estado vindo do datapagth
    input wire top,

	 // Sai­das de controle para o dispositivo
    output reg [2:0] lights
);

    reg [2:0] state;
    reg [2:0] next_state;

    // Registrador de estado
    always @(posedge clk) begin
        if (rst) state <= `STATE_RED_LOAD;
        else state <= next_state;
    end

    // Logica de proximo estado
    always @(*) begin
        next_state = `STATE_RED_LOAD;

        case (state)

            `STATE_RED_LOAD: next_state = `STATE_RED;

            `STATE_RED: begin
                if (top) next_state = `STATE_GREEN_LOAD;
                else next_state = `STATE_RED;
            end

            `STATE_GREEN_LOAD: next_state = `STATE_GREEN;

            `STATE_GREEN: begin
                if (top) next_state = `STATE_YELLOW_LOAD;
                else next_state = `STATE_GREEN;
            end

            `STATE_YELLOW_LOAD: next_state = `STATE_YELLOW;

            `STATE_YELLOW: begin
                if (top) next_state = `STATE_RED_LOAD;
                else next_state = `STATE_YELLOW;
            end

            default: next_state = `STATE_RED_LOAD;

        endcase
    end

    // Logica das saidas
    always @(*) begin

        // Valores padrao
        clear = 1'b0;
        sel = 2'd0;
        lights = 3'b100;

        case (state)

            // Preparacao do vermelho
            `STATE_RED_LOAD: begin
                clear = 1'b1;
                sel = 2'd0;
                lights = 3'b100;
            end

            // Vermelho ativo
            `STATE_RED: begin
                sel = 2'd0;
                lights = 3'b100;
            end

            // Preparacao do verde
            `STATE_GREEN_LOAD: begin
                clear = 1'b1;
                sel = 2'd1;
                lights = 3'b001;
            end

            // Verde ativo
            `STATE_GREEN: begin
                sel = 2'd1;
                lights = 3'b001;
            end

            // Preparacao do amarelo
            `STATE_YELLOW_LOAD: begin
                clear = 1'b1;
                sel = 2'd2;
                lights = 3'b010;
            end

            // Amarelo ativo
            `STATE_YELLOW: begin
                sel = 2'd2;
                lights = 3'b010;
            end

            default: begin
                clear = 1'b1;
                sel = 2'd0;
                lights = 3'b100;
            end

        endcase
    end
 
endmodule 