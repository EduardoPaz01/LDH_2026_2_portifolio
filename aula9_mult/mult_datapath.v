
module mult_datapath(
    input        clk,
    input  [3:0] a,
    input  [3:0] b,
    output [7:0] m,

    // Sinais de controle (vindo da FSM)
    input load,
    input clear,

    // Sinais de estado (indo para a FSM)
    output zero
);

    reg [7:0] acc;
    reg [7:0] reg_a;
    reg [3:0] reg_b;

    wire acc_enable;
	 assign acc_enable = reg_b[0];
	 
    wire [7:0] s_out;

    // Somador
    ripple_carry_adder #(.BITS(8)) adder(
        .a(acc),
        .b(reg_a),
        .s(s_out)
    );

    // Registrador A: deslocamento à esquerda
    always @(posedge clk) begin
        reg_a <= (load) ?
            ({4'b0000, a}) :
            ({reg_a[6:0], 1'b0});
    end

    // Registrador B: deslocamento à direita
    always @(posedge clk) begin
        reg_b <= (load) ?
            (b) :
            ({1'b0, reg_b[3:1]});
    end

    // Acumulador
    always @(posedge clk) begin
        acc <= (clear) ?
            (8'd0) :
            ((acc_enable) ? (s_out) : (acc));
    end

    // Saídas
    assign m = acc;
	 assign zero = ((reg_a==8'd0) || (reg_b==4'd0));

endmodule
