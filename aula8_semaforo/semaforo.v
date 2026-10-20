module semaforo (
    input  wire       clk_50M,
    input  wire       rst,
    output wire [2:0] lights
);

    wire clear;
    wire top;
    wire [1:0] sel;
    wire clk_1s;

    // Divisor de clock
    clk_1s u0 (
        .rst     (rst),
        .clk_50M (clk_50M),
        .clk_out (clk_1s)
    );

    // Máquina de estados
    semaforo_fsm u1 (
        .rst    (rst),
        .clk    (clk_1s),
        .sel    (sel),
        .clear  (clear),
        .top    (top),
        .lights (lights)
    );

    // Caminho de dados
    semaforo_datapath u2 (
        .clk   (clk_1s),
        .clear (clear),
        .sel   (sel),
        .top   (top)
    );
	 
endmodule 