module comb_mult #(
    parameter A_BITS = 4,
    parameter B_BITS = 4,
    parameter M_BITS = A_BITS + B_BITS
)(
    input  [A_BITS-1:0] a,
    input  [B_BITS-1:0] b,
    output [M_BITS-1:0] m
);

    wire [M_BITS-1:0] pp  [0:B_BITS-1];
    wire [M_BITS-1:0] acc [0:B_BITS-1];

    genvar i;

    // Geração dos produtos parciais
    generate
        for (i = 0; i < B_BITS; i = i + 1) begin : partial
            assign pp[i] = b[i]
                ? ({{(M_BITS-A_BITS){1'b0}}, a} << i)
                : {M_BITS{1'b0}};
        end
    endgenerate

    // Primeira etapa: produto parcial sem soma
    assign acc[0] = pp[0];

    // Somar os produtos parciais com crescimento progressivo
    generate
        for (i = 1; i < B_BITS; i = i + 1) begin : stages

            ripple_carry_adder #(
                .BITS(A_BITS + i + 1)
            ) add_stage (
                .a (acc[i-1][A_BITS+i-1:0]),
                .b (pp[i][A_BITS+i-1:0]),
                .s (acc[i][A_BITS+i:0])
            );

        end
    endgenerate

    assign m = acc[B_BITS-1];

endmodule
