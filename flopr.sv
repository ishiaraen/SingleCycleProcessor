module flopr 
			#(parameter width = 64)
			( input logic clk, reset,
			input logic [width-1:0] q,
			output logic [width-1:0] d);
	
	always_ff @(posedge clk, posedge reset) begin
		if (reset) d <= 0;
		else d <= q;
	end 
	
endmodule 