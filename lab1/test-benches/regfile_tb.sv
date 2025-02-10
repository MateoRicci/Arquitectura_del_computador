module regfile_tb();

	logic clk, we3;
	logic [4:0] ra1, ra2, wa3;
	logic [63:0] wd3;
	logic [63:0] rd1, rd2;

	regfile dut(clk, we3, ra1, ra2, wa3, wd3, rd1, rd2);
	int errors;
	

	always begin
		clk = 1; #10ns; clk = 0; #10ns;
	end
	
	initial begin
		errors = 0;
		
		we3 = 1'b0;
		ra1 = 5'b0;
		ra2 = 5'b0;
		wd3 = 64'b0;
		
		//reading test
		for(logic [4:0] i = 5'b0; i < 31; ++i) begin
			ra1 = i;
			ra2 = i;
			
			#10ns;
			if (rd1 !== i || rd2 !== i) begin
				$display("ERROR READING: %d" ,i+1);
				errors++;
			end
			#10ns;
		end
		
		//writing test
		we3 = 1'b1;
		for(logic [4:0] i = 5'b0; i < 31; ++i) begin
			wd3 = $random;
			wa3 = i;
			ra1 = i;
			ra2 = i;
			
			#10ns;
				if (rd1 !== wd3 || rd2 !== wd3) begin
					$display("ERROR WRITING: %d" ,i+1);
					errors++;
				end
			#10ns;
		end
		
		//writing deactivate test
		we3 = 1'b0;
		for(logic [4:0] i = 5'b0; i < 31; ++i) begin
			logic [63:0] prev1, prev2;
			ra1 = i;
			ra2 = i;
			
			#10ns;
			prev1 = rd1;
			prev2 = rd2;
			#10ns;
			
			wd3 = 64'b0; // posibilidad de fallo = 1/2^64
			wa3 = i;
			
			#10ns;
			$display("RD1: %d", rd1);
			$display("RD2: %d", rd2);
			if (rd1 !== prev1 || rd2 !== prev2) begin
				$display("ERROR FALSE WRITING: %d" ,i+1);
				errors++;
			end
			#10ns;
		end
		
		$display("Total errors: %d", errors);
		$stop;
		
	end

endmodule