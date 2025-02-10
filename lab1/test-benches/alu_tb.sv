module alu_tb();

	logic [196:0] data [29:0] = {
		//a       b         control  result    zero
		{64'd0  , 64'd0   , 4'b0000, 64'd0   , 1'b1}, // &
		{64'd0  , 64'd0   , 4'b0001, 64'd0   , 1'b1}, // |
		{64'd0  , 64'd0   , 4'b0010, 64'd0   , 1'b1}, // +
		{64'd0  , 64'd0   , 4'b0110, 64'd0   , 1'b1}, // -
		{64'd0  , 64'd0   , 4'b0111, 64'd0   , 1'b1}, // pass b

		{64'd593, 64'd0   , 4'b0000, 64'd0   , 1'b1}, // &
		{64'd593, 64'd0   , 4'b0001, 64'd593 , 1'b0}, // |
		{64'd593, 64'd0   , 4'b0010, 64'd593 , 1'b0}, // +
		{64'd593, 64'd0   , 4'b0110, 64'd593 , 1'b0}, // -
		{64'd593, 64'd0   , 4'b0111, 64'd0   , 1'b1},  // pass b

		{64'd0  , -64'd635, 4'b0000, 64'd0   , 1'b1}, // &
		{64'd0  , -64'd635, 4'b0001, -64'd635, 1'b0}, // |
		{64'd0  , -64'd635, 4'b0010, -64'd635, 1'b0}, // +
		{64'd0  , -64'd635, 4'b0110, 64'd635 , 1'b0}, // -
		{64'd0  , -64'd635, 4'b0111, -64'd635, 1'b0}, // pass b

		{64'd239, 64'd26  , 4'b0000, 64'd10  , 1'b0}, // &
		{64'd239, 64'd26  , 4'b0001, 64'd255 , 1'b0}, // |
		{64'd239, 64'd26  , 4'b0010, 64'd265 , 1'b0}, // +
		{64'd239, 64'd26  , 4'b0110, 64'd213 , 1'b0}, // -
		{64'd239, 64'd26  , 4'b0111, 64'd26  , 1'b0}, // pass b

		{-64'd98, -64'd407, 4'b0000, -64'd504, 1'b0}, // &
		{-64'd98, -64'd407, 4'b0001, -64'd1  , 1'b0}, // |
		{-64'd98, -64'd407, 4'b0010, -64'd505, 1'b0}, // +
		{-64'd98, -64'd407, 4'b0110, 64'd309 , 1'b0}, // -
		{-64'd98, -64'd407, 4'b0111, -64'd407, 1'b0}, // pass b

		{64'd930, -64'd33 , 4'b0000, 64'd898 , 1'b0}, // &
		{64'd930, -64'd33 , 4'b0001, -64'd1  , 1'b0}, // |
		{64'd930, -64'd33 , 4'b0010, 64'd897 , 1'b0}, // +
		{64'd930, -64'd33 , 4'b0110, 64'd963 , 1'b0}, // -
		{64'd930, -64'd33 , 4'b0111, -64'd33 , 1'b0}  // pass b
	};
		
		logic [63:0] a, b;
		logic [3:0] ALUControl;
		logic [63:0] result, expected_result;
		logic zero, expected_zero;

		alu dut(a, b, ALUControl, result, zero);
		
		logic [31:0] errors;
		logic [31:0] err;
		always begin
		
			errors = 0;
			
			for (int i=0; i<30; ++i) begin
				err = errors;
				#1ns;
				$display("TEST: %d",(i+1));
				{a, b, ALUControl, expected_result, expected_zero} = data[i];
				#1ns;
				if (result !== expected_result) begin
					$display("ERROR: result !== expected_result");
					$display("ERROR: result: %d",result);
					$display("ERROR: expected_result: %d",expected_result);
					errors++;
				end
				if (zero !== expected_zero) begin
					$display("ERROR: zero !== zero_result");
					$display("ERROR: zero: %d",zero);
					$display("ERROR: zero_result: %d",zero);
					errors++;
				end
				if(err === errors) begin
					$display("PASSED");
				end
				#1ns;
			end
			$display("Total errors: %d", errors);
			$stop;
		end

endmodule