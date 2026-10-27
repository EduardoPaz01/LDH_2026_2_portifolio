module full_adder (
	input a, // wire está implícito no input a, ou seja, "input wire a"
	input b,
	input ci,
	output s,
	output co
);

	// Modelagem Estrutural
	// 	: Saída carry out
	wire w1, w2, w3;
	and u1 (w1, a,  b);// não podemos ligar saídas em um reg, somente wire, pelo fato de serem conexões
	and u2 (w2, ci, b);
	and u3 (w3, ci, a);
	or  u4 (co , w1, w2, w3);
	
	// 	: Saída soma
	wire na, nb, nci;
	not u5  (na, a);
	not u6  (nb, b);
	not u7  (nci, c);
	wire w4, w5, w6, w7;
	and u8  (w4, a, b, ci);
	and u9  (w5, na, b, nci);
	and u10 (w6, na, nb, ci);
	and u11 (w7, a, nb, nci);
	or  u12 (s , w4, w5, w6, w7);
	
endmodule
