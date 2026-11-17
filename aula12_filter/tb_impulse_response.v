
`timescale 100ns/1ns

module tb_impulse_response;

    reg rst, clk;
    reg signed  [11:0] x;
    wire signed [11:0] y;

    // Geração do clock
    always #5 clk = ~clk; // Clock 1Mhz

    // Instância do filtro
    bw2_filter dut (
        .rst(rst),
        .clk(clk),
        .x(x),
        .y(y)
    );
	 
	 integer f;
	 
	  // Monitoramento dos sinais no terminal
		initial begin
		  $monitor("t=%0t | rst=%b | clk=%b | x=%d | y=%d",
					  $time, rst, clk, x, y);
		end

		// Gravação dos dados no arquivo CSV
		always @(posedge clk) begin
		  if (f != 0) begin
				$fwrite(f, "%0t,%b,%b,%d,%d\n",
						  $time, rst, clk, x, y);
		  end
		end

    // Estímulo de entrada
    initial begin
		  f = $fopen("output.csv", "w");
		  $fwrite(f, "tempo,rst,clk,x,y\n");
        clk = 1;
		  rst = 1;
        x = 12'sd0;

        #16;
        rst = 0;

        // Aplicação do impulso
        x = 12'sb010000000000;

        #10;
        x = 12'sd0;

        // Aguarda a resposta do filtro
        #50;

		  $fclose(f);
        $finish;
    end

endmodule
