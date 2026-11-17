
`timescale 100ns/1ns

module tb_transfer;

	  localparam integer CYCLES = 10;
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
	 
	 integer f, i;
	 
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
		  x   = 0;
        #10;
		  rst = 0;
		  
		  //x = 2048, 3251, 3995, 3995, 3251, 2048, 844, 100, 100, 844
		  for (i = 0; i < CYCLES; i = i + 1) begin
			  #10 x = 12'sd0;
			  #10 x = 12'sd301;
			  #10 x = 12'sd487;
			  #10 x = 12'sd487;
			  #10 x = 12'sd301;
			  #10 x = 12'sd0;
			  #10 x = -12'sd302;
			  #10 x = -12'sd488;
			  #10 x = -12'sd488;
			  #10 x = -12'sd302;
		  end
		  #10 x = 12'sd0;
		  

        // Aguarda a resposta do filtro
        #300;

		  $fclose(f);
        $finish;
    end

endmodule
