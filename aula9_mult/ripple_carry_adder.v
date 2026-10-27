
module ripple_carry_adder #(
    parameter BITS = 8
)(
    input  [BITS-2:0] a,
    input  [BITS-2:0] b,
    output [BITS-1:0] s
);

    wire [BITS-1:0] c;

    assign c[0] = 1'b0;

    genvar i;
    generate
        for (i = 0; i < BITS-1; i = i + 1) begin : fa
            full_adder u_fa (
                .a  (a[i]),
                .b  (b[i]),
                .ci (c[i]),
                .s  (s[i]),
                .co (c[i+1])
            );
        end
    endgenerate
	 
    assign s[BITS-1] = c[BITS-1];

endmodule
