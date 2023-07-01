// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);

// Put your code here
// ------------------
logic [15:0] out16;
logic [7:0] out8;


//4:1 mux
always_comb begin
	case(a_sel)
		2'b00: out8 = a[7:0];
		2'b01: out8 = a[15:8];
		2'b10: out8 = a[23:16];
		2'b11: out8 = a[31:24];
	endcase
end

//2:1 mux
always_comb begin
	case(b_sel)
		1'b0: out16 = b[15:0];
		1'b1: out16 = b[31:16];
	endcase
end

//16x8 Multiplier
logic [23:0] mult;
always_comb begin
	mult = out16 * out8;
end

//shift mux

logic [63:0] shifted;
//logic [63:0] extended_mult;
always_comb begin
	shifted = 64'b0;
	case(shift_sel)
		3'b000: shifted = mult;
		3'b001: shifted = mult << 8; 
		3'b010: shifted = mult << 16;
		3'b011: shifted = mult << 24;
		3'b100: shifted = mult << 32;
		3'b101: shifted = mult << 40;
	endcase
end

//product register and 64 bit adder
always_ff @(posedge clk, posedge reset) begin
	if(reset == 1'b1) begin 
		product <= 64'b0;
	end
	
	else begin
		if(clr_prod == 1'b1) begin
			product <= 64'b0;
		end
		else if (upd_prod == 1'b1) begin
			product <= product + shifted;
		end
	
	end
	
	
end

// End of your code





























//michelle

endmodule
