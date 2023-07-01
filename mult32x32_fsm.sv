// 32X32 Multiplier FSM
module mult32x32_fsm (
    input logic clk,              // clk
    input logic reset,            // Reset
    input logic start,            // Start signal
    output logic busy,            // Multiplier busy indication
    output logic [1:0] a_sel,     // Select one byte from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [2:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);

// Put your code here
// ------------------
	typedef enum { idle, handle1, handle2, handle3, handle4, handle5, handle6, handle7, handle8} sm_type;
	
	sm_type current_state;
	sm_type next_state;
	
	
	//Fsm synchronous procedural block
	always_ff @(posedge clk, posedge reset) begin
		if (reset== 1'b1) begin
			current_state <=idle;
		end
		else begin
			current_state <= next_state;
		end
	end
	
	
	
	//Async logic
	always_comb begin
		//defults
		next_state= current_state;
		busy=1'b1;
		upd_prod= 1'b1;
		clr_prod= 1'b0;
		a_sel= 2'b0;
		b_sel= 1'b0;
		shift_sel= 3'b0;
		case(current_state)
			idle: begin
				if(start== 1'b0) begin
					next_state=idle;
					busy=1'b0;
					upd_prod=1'b0;
				end
				else begin
					next_state=handle1;
					busy=1'b0;
					upd_prod=1'b0;
					clr_prod=1'b1;
				end
			end
			
			
			handle1: begin
				next_state= handle2;
				a_sel=2'b0;
				b_sel=1'b0;
				shift_sel=3'b0;
			end
			
			
			handle2: begin
				next_state= handle3;
				a_sel=2'b01;
				b_sel=1'b0;
				shift_sel=3'b001;
			end
			
			
			handle3: begin
				next_state= handle4;
				a_sel=2'b10;
				b_sel=1'b0;
				shift_sel=3'b010;
			end
			
			
			handle4: begin
				next_state= handle5;
				a_sel=2'b11;
				b_sel=1'b0;
				shift_sel=3'b011;
			end
			
			
			handle5: begin
				next_state= handle6;
				a_sel=2'b0;
				b_sel=1'b1;
				shift_sel=3'b010;
			end
			
			
			handle6: begin
				next_state= handle7;
				a_sel=2'b01;
				b_sel=1'b1;
				shift_sel=3'b011;
			end
			
			
			handle7: begin
				next_state= handle8;
				a_sel=2'b10;
				b_sel=1'b1;
				shift_sel=3'b100;
			end
			
			
			handle8: begin
				next_state= idle;
				a_sel=2'b11;
				b_sel=1'b1;
				shift_sel=3'b101;
			end
		endcase
	end

// End of your code

endmodule
