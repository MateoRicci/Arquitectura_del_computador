module maindec(
    input logic [10:0] Op,
    output logic Reg2Loc, 
    output logic ALUSrc, 
    output logic MemtoReg, 
    output logic RegWrite, 
    output logic MemRead, 
    output logic MemWrite, 
    output logic Branch,
    output logic [1:0] ALUOp
);

    always_comb begin
        casez (Op)
            11'b111_1100_0010: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 9'b011110000; 
            11'b111_1100_0000: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 9'b110001000;
            11'b101_1010_0???: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 9'b100000101;
            11'b100_0101_1000, 
            11'b110_0101_1000, 
            11'b100_0101_0000, 
            11'b101_0101_0000: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 9'b000100010;
				11'b100_1000_100?,
				11'b110_1000_100?: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 9'b010100010;
            default: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 9'b000000000;
        endcase
    end

endmodule
