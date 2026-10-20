module semaforo_datapath(
	input 		 clk,
	
	//Sinais de controle vindo da FSM
	input			 clear,
	input  [1:0] sel,
	
	//Sinais de saída indo para a FSM
	output 		 top
);

	wire [4:0] cnt;
	reg [4:0] sel_time;

	counter u1(
		.rst(clear),
		.clk(clk),
		.cnt_out(cnt)
	);
	
	// Comparador de match de contagem
	assign top = (cnt == sel_time);
	
	// Multiplexador para seleção de tempo
	always @(*) begin
		case (sel)
			0: sel_time = 20;
			1: sel_time = 2;
			2: sel_time = 10;
			default: sel_time = 31;
		endcase 
	end

endmodule 