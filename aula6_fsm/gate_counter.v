`define S0  4'd0
`define S10 4'd10

module gate_counter (
    input wire rst,
    input wire clk,
    input wire dir,
    input wire enable,
    output reg start_stop,
    output reg end_stop,
    output reg [9:0] led_bar
);

    reg [3:0] state, nextstate;

    // Registrador de estado: reset síncrono
    always @(posedge clk) begin
        if (rst) state <= `S0;
        else state <= nextstate;
    end

    // Lógica de transição
    always @(*) begin
        nextstate = state;

        if (state == `S0) begin
            // Inicia a abertura
            if (dir && enable && start_stop) nextstate = 4'd1;
        end
        else if (state < `S10) begin
            // Estados intermediários: S1 a S9
            if (enable) begin
                if (dir) nextstate = state + 1'b1; // Abrir
                else     nextstate = state - 1'b1; // Fechar
            end
				
        end
        else if (state == `S10) begin
            // Portão totalmente aberto
            if (enable && end_stop && !dir) nextstate = state - 1'b1;
        end
        else begin
            nextstate = `S0;
        end
    end

    // Barra de LEDs: indica a posição do portão
    always @(*) begin
         if (state == 0) begin
            led_bar = 10'b0000000001;
				start_stop = 1'b1;
			   end_stop = 1'b0;
		   end else if (state >= 10) begin
            led_bar = 10'b1111111111;
				start_stop = 1'b0;	
				end_stop = 1'b1;
         end else begin
            led_bar = (10'b0000000001 << state) - 1'b1;
				start_stop = 1'b0;
			   end_stop = 1'b0;
			end
    end

endmodule