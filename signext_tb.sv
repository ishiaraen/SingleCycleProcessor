module signext_tb();
	logic clk;
	logic [31:0] a;
	logic [63:0] y, yexp;
	logic [31:0] ainput [0:5] = '{32'b111_1100_0010_011110101_11_11011_10001,
											32'b111_1100_0000_100110101_11_10011_10101,
											32'b111_1100_0000_011110100_01_10011_01100,
											
											32'b101_1010_0_1101111101011110001_01111,
											32'b101_1010_0_0000111101011111011_10101,
											
											32'b001_1100_0000_1111_1010_1111_0011_1110_0};
											
	logic [63:0] arrayexpected [0:5] = '{64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1111_0101,
										64'b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_0011_0101,
										64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1111_0100,
										64'b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1110_1111_1010_1111_0001,
										64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0111_1010_1111_1011,
										64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000};
	
	logic [31:0] indice, errors;
	signext dut(a,y);
	initial begin
		errors = 0; indice = 0;
		a=0;
		yexp = 0;
	end
	
	always begin
		clk = 1; #5ns;
		clk = 0; #5ns;
	end
	
	always @(posedge clk) begin
		#1ns;
		if(y !== yexp)begin
			errors = errors +1;
		end
		if (indice === 6) begin
			$display("%d tests completed with %d errors",indice, errors);
			$stop;
		end
	end
	
	always @(negedge clk) begin
		a<=ainput[indice];
		yexp<=arrayexpected[indice];
		indice<=indice+1;
	end
endmodule 

