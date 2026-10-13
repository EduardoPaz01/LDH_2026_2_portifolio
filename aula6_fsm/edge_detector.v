`define UP        2'd0
`define B_PRESS   2'd1
`define DOWN      2'd2
`define B_RELEASE 2'd3

module edge_detector (
    input  wire clk,
    input  wire rst,
    input  wire button,
    output wire but_press,
    output wire but_release
);

    reg [1:0] state, nextstate;

    always @(posedge clk) begin
        if (rst)
            state <= `UP;
        else
            state <= nextstate;
    end

    always @(*) begin
        nextstate = state;

        case (state)
            `UP:        nextstate = button ? `B_PRESS : `UP;
            `B_PRESS:   nextstate = `DOWN;
            `DOWN:      nextstate = button ? `DOWN : `B_RELEASE;
            `B_RELEASE: nextstate = `UP;
            default:    nextstate = `UP;
        endcase
    end

    assign but_press   = (state == `B_PRESS);
    assign but_release = (state == `B_RELEASE);

endmodule 