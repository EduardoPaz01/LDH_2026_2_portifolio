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
		#1
		$monitor("Test [1]: %b + %b = %b ", a, b, s);
		#1
		if(s==5'd0) begin
			$monitor("Test [1] : PASS");
		end else begin
			$monitor("Test [1] : FAIL");
		end
		
		#10
		

		a = 1; b = 1;
		#1
		$monitor("Test [2]: %b + %b = %b ", a, b, s);
		#1
		if(s==5'd2) begin
			$monitor("Test [2] : PASS");
		end else begin
			$monitor("Test [2] : FAIL");
		end
		
		#10
		
		a = 3; b = 5;
		#1
		$monitor("Test [3]: %b + %b = %b ", a, b, s);
		#1
		if(s==5'd8) begin
			$monitor("Test [3] : PASS");
		end else begin
			$monitor("Test [3] : FAIL");
		end
			
		#10
		
		a = 7; b = 9;
		#1
		$monitor("Test [4]: %b + %b = %b ", a, b, s);
		#1
		if(s==5'd16) begin
			$monitor("Test [4] : PASS");
		end else begin
			$monitor("Test [4] : FAIL");
		end
		
		#10
		
		$finish;
	end 
	

endmodule
