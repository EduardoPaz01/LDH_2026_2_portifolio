module movavg_filter (
	input  clk,
	input  rst,
	input  [11:0] x,
	
	output reg[11:0] y
);

	reg [11:0] x1, x2, x3;
	wire [13:0] sum;
	
	always @(posedge clk) begin
		if(rst) begin
			x1 <= 12'd0;
			x2 <= 12'd0;
			x3 <= 12'd0;
		end else begin
			x1 <= x;
			x2 <= x1;
			x3 <= x2;
			y  <= sum[13:2];
		end
	end
	
	assign sum = (x + x1 + x2 + x3);

endmodule 