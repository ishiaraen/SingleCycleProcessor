module flopr_tb();
	logic clk, reset;
	logic [63:0] q, d, dexp;
	logic [63:0] qinput [0:9] = {64'h1,64'hA2,64'hBA,64'h10,64'h51,
											64'hA2,64'hCC,64'h55,64'h123,64'h1010};
	logic [63:0] dexpected [0:9] = {64'h0,64'h0,64'h0,64'h0,64'h0,
											64'hA2,64'hCC,64'h55,64'h123,64'h1010};
	logic [31:0] vectornum, errors;
	flopr #(64) dut(clk, reset, q, d);

	always begin
			clk = 1; #5ns;
			clk = 0; #5ns;
	end
	
	always @(negedge clk) begin  
		if (vectornum === 10) begin 
		   $display("%d tests completed with %d errors", vectornum, errors);
			$stop;
		end
	end
	
	always @(negedge clk) begin
		q <= qinput[vectornum];
		dexp <= dexpected[vectornum];
		vectornum<=vectornum+1;
	end
	
	always @(posedge clk) begin
		#5ns;
		if (d !== dexp) begin  
			$display("Error: inputs = %b", q);
			$display("outputs = %b (%b expected)",d,q);
			errors = errors + 1;
		end
   end	
	
	initial begin
			errors = 0; vectornum = 0; q =0;
			reset = 1; #50ns;
			reset = 0;
	end
	
endmodule 