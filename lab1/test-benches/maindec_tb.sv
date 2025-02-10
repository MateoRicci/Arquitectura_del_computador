module maindec_tb();
	logic [10:0] opcode;
	logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
	logic [1:0] ALUOp;
	
	maindec dut(opcode, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
	
	logic expected_Reg2Loc, expected_ALUSrc, expected_MemtoReg, expected_RegWrite, expected_MemRead, expected_MemWrite, expected_Branch;
	logic [1:0] expected_ALUOp;

	logic [19:0] inputs_outputs [0:7] = {
	{11'b11111000010,1'b0,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,2'b00},
	{11'b11111000000,1'b1,1'b1,1'b0,1'b0,1'b0,1'b1,1'b0,2'b00},
	{11'b10110100101,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,2'b01},
	{11'b10001011000,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,2'b10},
	{11'b11001011000,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,2'b10},
	{11'b10001010000,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,2'b10},
	{11'b10101010000,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,2'b10},
	{11'b00000000000,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,2'b00}
	};
	
	int errors = 0;
	
	initial begin
	
		for(int i = 0; i < 8; ++i) begin
			#1ns;
				
			{opcode,expected_Reg2Loc, expected_ALUSrc, expected_MemtoReg, expected_RegWrite, expected_MemRead, expected_MemWrite, expected_Branch, expected_ALUOp} = inputs_outputs[i];
			
			#1ns;
			
			if({Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} !==
					{expected_Reg2Loc, expected_ALUSrc, expected_MemtoReg, expected_RegWrite, expected_MemRead, expected_MemWrite, expected_Branch,expected_ALUOp}) begin
				errors++;
				$display("ERROR TEST: %d", i+1);
			
			end
			
			#1ns;
		end
	
		$display("Total errors: %d", errors);
		$stop;
	
	end
	
endmodule

	