module signext_tb();
	
							          // format: op_addr_etc
	logic [63:0] outputs [6:0] = '{64'b0000000000000000000000000000000000000000000000000000000011100101, // pos ldur
											64'b1111111111111111111111111111111111111111111111111111111111100101, // neg ldur
											64'b0000000000000000000000000000000000000000000000000000000011100101, // pos stur
											64'b1111111111111111111111111111111111111111111111111111111111100101, // neg stur
											64'b0000000000000000000000000000000000000000000000011010001111111010, // pos cbz
											64'b1111111111111111111111111111111111111111111111011010001111111010, // neg cbz
											1'b0 // fail
											};
											
	logic [31:0] inputs [6:0] = '{32'b11111000010_011100101_000010010110, // pos ldur
											32'b11111000010_111100101_000010010110, // neg ldur
											32'b11111000000_011100101_000010010110, // pos stur
											32'b11111000000_111100101_000010010110, // neg stur
											32'b10110100_001101000111111101000011, // pos cbz
											32'b10110100_101101000111111101000011, // neg cbz
											32'b00000000000000000000000000000000 // fail
											};
											
	
	logic [31:0] a;
	logic [63:0] y;
	
	signext dut(a,y);
	
	logic [31:0] errors;
	always begin
		errors = 0;
		for (int i=0; i<7; ++i) begin
			
			a = inputs[i];
			#1ns;
			if (y !== outputs[i]) begin
				errors = errors + 1;
				$display("ERROR:\n  expected = %d, got = %d\n  in=%b", outputs[i], y, a);
			end
			else if(y === outputs[i]) begin
				$display("test %d passed", i+1);
			end
			
		end
		$display("Total errors: %d", errors);
		$stop;
	end
	
	
	

endmodule