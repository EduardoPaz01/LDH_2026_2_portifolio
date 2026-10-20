module counter (
    input wire rst,
    input wire clk,
    output wire [4:0] cnt_out
);

    reg [4:0] cnt;

    always @(posedge clk) begin
        if (rst)
            cnt <= 5'd0;
        else
            cnt <= cnt + 5'd1;
    end

    assign cnt_out = cnt;

endmodule