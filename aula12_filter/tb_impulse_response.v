
`timescale 100ns/1ns

module tb_impulse_response;

    reg rst, clk;
    reg [11:0] x;
    wire [11:0] y;

    // Geração do clock
    always #5 clk = ~clk; // Clock 1Mhz

    // Instância do filtro
    movavg_filter dut (
        .rst(rst),
        .clk(clk),
        .x(x),
        .y(y)
    );

    // Estímulo de entrada
    initial begin
        clk = 1;
		  rst = 1;
        x = 12'd0;

        #15;
        rst = 0;

        // Aplicação do impulso
        x = 12'b100000000000;

        #10;
        x = 12'd0;

        // Aguarda a resposta do filtro
        #50;

        $finish;
    end

endmodule
