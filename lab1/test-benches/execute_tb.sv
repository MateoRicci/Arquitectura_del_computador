`timescale 1ns / 10ps

module execute_tb();
	logic AluSrc;
	logic [3:0] AluControl;
	logic [63:0] PC_E, signImm_E, readData1_E, readData2_E;
	logic [63:0] PCBranch_E, aluResult_E, writeData_E;
	logic zero_E;
	
	execute dut(AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E,
					PCBranch_E, aluResult_E, writeData_E, zero_E);
	
	logic [31:0] errors;
	
	logic [3:0] AluControl_Data [0:4] = {4'b000, 4'b0001, 4'b0010, 4'b0110, 4'b0111};
	
	logic [192:0] expected_outputs [0:9] = 
	//ALUSrc = 0
	//PCBranch_E, aluResult_E, writeData_E, zero_E
	{{64'd20, 		64'd0, 		64'd1, 			1'b1},//AND
	 {64'd20, 		64'd11, 		64'd1, 			1'b0},//OR
	 {64'd20, 		64'd11, 		64'd1, 			1'b0},//ADD
	 {64'd20, 		64'd9, 		64'd1, 			1'b0},//SUB
	 {64'd20, 		64'd1, 		64'd1, 			1'b0},//PASSB
	//ALUSrc = 1
	 {64'd20, 		64'd0, 		64'd1, 			1'b1},//AND
	 {64'd20, 		64'd14, 		64'd1, 			1'b0},//OR
	 {64'd20, 		64'd14, 		64'd1, 			1'b0},//ADD
	 {64'd20, 		64'd6, 		64'd1, 			1'b0},//SUB
	 {64'd20, 		64'd4, 		64'd1, 			1'b0}//PASSB
	 };
	
	initial
		begin
			errors = 0;
			PC_E = 64'd4;
			signImm_E = 64'd4;
			readData1_E = 64'd10;
			readData2_E = 64'd1;
			AluSrc = 0;
			AluControl = 0;
			
			#1;
			for(int k = 0; k < 5; k++)
				begin
					AluControl = AluControl_Data[k];
					#1;
					
					AluSrc = 0;
					#1;
					if ({PCBranch_E, aluResult_E, writeData_E, zero_E} !== expected_outputs[k])
						begin
							errors = errors + 1;
							$display("Error AluSrc = 0, AluControl = %b - expected: result = %b \ngot: PCBranch_E = %b, aluResult_E = %b, writeData_E = %b, zero_E = %b"
										, AluControl_Data[k], expected_outputs[k], PCBranch_E, aluResult_E, writeData_E, zero_E);
						end
					#1;
					
					AluSrc = 1;
					#1;
					if ({PCBranch_E, aluResult_E, writeData_E, zero_E} !== expected_outputs[k+5])
						begin
							errors = errors + 1;
							$display("Error AluSrc = 1, AluControl = %b - expected: result = %b \ngot: PCBranch_E = %b, aluResult_E = %b, writeData_E = %b, zero_E = %b"
									, AluControl_Data[k], expected_outputs[k+5], PCBranch_E, aluResult_E, writeData_E, zero_E);
						end
					#1;
				end
				
			$display("Total errors: %d", errors);
		end
	
endmodule

//0000 a AND b
//0001 a OR b
//0010 add (a+b)
//0110 sub (a-b)
//0111 pass input b