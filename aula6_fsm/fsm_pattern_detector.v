`define S0 3'd0
`define S1 3'd1
`define S2 3'd2
`define S3 3'd3
`define S4 3'd4

module fsm_pattern_detector (
    input  wire rst,
    input  wire clk,

    // Sinal de entrada
    input  wire in_bit,

    // Sinal de saída
    output wire match
);

    reg [2:0] state;
    reg [2:0] nextstate;

    // Registrador de estado: reset síncrono
    always @(posedge clk) begin
        if (rst) begin
            state <= `S0;
        end else begin
            state <= nextstate;
        end
    end

    // Lógica combinacional de transição
    always @(*) begin
        // Valor padrão para evitar latches
        nextstate = `S0;

        case (state)
            `S0: nextstate = in_bit ? `S1 : `S0;
            `S1: nextstate = in_bit ? `S2 : `S0;
            `S2: nextstate = in_bit ? `S2 : `S3;
            `S3: nextstate = in_bit ? `S4 : `S0;
            `S4: nextstate = `S4;

            default: nextstate = `S0;
        endcase
    end

    // Lógica combinacional de saída
    assign match = (state == `S4);
	 
endmodule 