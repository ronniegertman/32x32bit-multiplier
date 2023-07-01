// 32X32 Multiplier test template
module mult32x32_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Put your code here
// ------------------

//module instanciation
mult32x32 multiplier(
	.clk(clk),
	.reset(reset),
	.start(start),
	.a(a),
	.b(b),
	.busy(busy),
	.product(product)
);




initial begin
	clk=1'b0;
	start=1'b0;
	#10
	reset=1'b1;
	#8
	reset=1'b0;
	#2
	a=325943165;
	b=326693694;
	#2
	start=1'b1;
	#2
	start=1'b0;
end
always begin
	#1
	clk= ~clk;
end


// End of your code

endmodule
