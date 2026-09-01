
module full_adder (
	input a, // wire está implícito no input a, ou seja, "input wire a"
	input b,
	input ci,
	output s,
	output co
);

	// Modelagem dataflow
	assign s = ( a & b & ci ) | ( ~a & b & ~ci ) | ( ~a & ~b & ci ) | ( a & ~b & ~ci );
	assign co = ( a & b ) | ( ci & b ) | ( ci & a );
	
endmodule
