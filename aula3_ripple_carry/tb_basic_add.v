`timescale 1us/1us 

module tb_basic_add;

	// Sinais
	reg [3:0] a;
	reg [3:0] b;
	wire [4:0] s;
	
	// Instânicia do dut
	adder_4b dut (
		.a(a), .b(b), .s(s)
	);
	
	// Estímulos
	initial begin // Bloco que executa apenas uma vez, Esse bloco não é sintetizado, usado apenas para debug e tb
		a = 0; b = 0;
		#10
		a = 1; b = 1;
		#10
		a = 3; b = 5;
		#10
		a = 7; b = 9;
		#10
		$finish;
	end 
	

endmodule
