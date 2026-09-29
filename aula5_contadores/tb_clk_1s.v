`timescale 10ns/1ns

module tb_clk_1s;

	 reg rst;
    reg  clk_50M;
    wire clk_out;

    // Instância do módulo que está sendo testado
    clk_1s dut (
		  .rst(rst),
        .clk_50M(clk_50M),
        .clk_out(clk_out)
    );

    // Clock de 50 MHz: período = 20 ns
    always #1 clk_50M = ~clk_50M;

    initial begin
        clk_50M = 1'b0;
		  rst = 1'b1;
		  #2;
		  rst = 1'b0;

        // Simula por 2 segundos
        #1_000_000_000;

        $finish;
    end

endmodule
