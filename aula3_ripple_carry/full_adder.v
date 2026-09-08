`timescale 1ns/1ns

module full_adder (
	input a, // wire está implícito no input a, ou seja, "input wire a"
	input b,
	input ci,
	output s,
	output co
);

	// Modelagem dataflow
	//assign s = ( a & b & ci ) | ( ~a & b & ~ci ) | ( ~a & ~b & ci ) | ( a & ~b & ~ci );
	//assign co = ( a & b ) | ( ci & b ) | ( ci & a );
	
	// Modelagem Estrutural
	// 	: Saída carry out
	wire w1, w2, w3;
	and #20 u1 (w1, a,  b);// não podemos ligar saídas em um reg, somente wire, pelo fato de serem conexões
	and #20 u2 (w2, ci, b);
	and #20 u3 (w3, ci, a);
	or  #30 u4 (co , w1, w2, w3);
	
	// 	: Saída soma
	wire na, nb, nci;
	wire w4, w5, w6, w7;
	not #10 u10 (na, a);
	not #10 u11 (nb, b);
	not #10 u12 (nci, c);
	and #30 u5 (w4, a, b, ci);
	and #30 u6 (w5, na, b, nci);
	and #30 u7 (w6, na, nb, ci);
	and #30 u8 (w7, a, nb, nci);
	or  #40 u9 (s , w4, w5, w6, w7);
	
endmodule
