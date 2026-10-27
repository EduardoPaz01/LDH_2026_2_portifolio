module comb_mult (
    input  [3:0] a,
    input  [3:0] b,
    output [7:0] m
);

    wire [6:0] aw1, aw2, aw3, aw4;
    wire [7:0] sw1, sw2, sw3;

    // Produtos parciais
    assign aw1 = b[0] ? {3'b000, a}       : 7'd0;
    assign aw2 = b[1] ? {2'b00, a, 1'b0}  : 7'd0;
    assign aw3 = b[2] ? {1'b0, a, 2'b00}  : 7'd0;
    assign aw4 = b[3] ? {a, 3'b000}       : 7'd0;

    // Soma dos produtos parciais 0 e 1
    ripple_carry_adder s1 (
        .a(aw1),
        .b(aw2),
        .s(sw1)
    );

    // Soma do resultado anterior com o produto parcial 2
    ripple_carry_adder s2 (
        .a(sw1[6:0]),
        .b(aw3),
        .s(sw2)
    );

    // Soma do resultado anterior com o produto parcial 3
    ripple_carry_adder s3 (
        .a(sw2[6:0]),
        .b(aw4),
        .s(sw3)
    );

    assign m = sw3;

endmodule 