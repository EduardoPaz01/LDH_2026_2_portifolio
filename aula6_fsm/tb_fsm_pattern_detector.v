`timescale 1us/1us

module tb_fsm_pattern_detector;

    // Sinais
    reg rst;
    reg clk;
    reg in_bit;
    wire match;

    // Instância do DUT
    fsm_pattern_detector dut (
        .rst(rst),
        .clk(clk),
        .in_bit(in_bit),
        .match(match)
    );

    always #1 clk = ~clk;
	 
    initial begin
        clk = 0;
        rst = 1;
        in_bit = 0;

        #1;
        rst = 0;

        #2 in_bit = 0;
        #2 in_bit = 0;
        #2 in_bit = 1;
        #2 in_bit = 0;
        #2 in_bit = 1;
        #2 in_bit = 1;
        #2 in_bit = 0;
        #2 in_bit = 1;
        #2 in_bit = 0;
        #2 in_bit = 0;

        $finish;
    end

endmodule
