`timescale 1us/1us 

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
	
	// Modelagem Carry out
	wire w1, w2, w3;
	and #1 u1 (w1, a,  b);
	and #1 u2 (w2, ci, b);
	and #1 u3 (w3, ci, a);
	or  #1 u4 (co , w1, w2, w3);
	
	wire w4, w5, w6, w7;
	and #1 u5 (w4, a, b, ci);
	and #1 u6 (w5, ~a, b, ~ci);
	and #1 u7 (w6, ~a, ~b, ci);
	and #1 u8 (w7, a, ~b, ~ci);
	or  #1 u9 (s , w4, w5, w6, w7);
	
endmodule
