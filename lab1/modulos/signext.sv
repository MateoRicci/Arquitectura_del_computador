module signext(input logic [31:0] a, output logic [63:0] y);

	always_comb
		casez(a[31:21])
			11'b11111000010, // LDUR
			11'b11111000000: // STUR
				y = {{55{a[20]}}, a[20:12]}; // repetis 55 veces el adrres mas significativo
			11'b10110100???: // CBZ
				y = {{45{a[23]}}, a[23:5]}; // repetis 45 veces el mas significativo
			11'b100_1000_100?, 11'b110_1000_100?: // estas son para los ADDI y SUBI (opcodes)
				y = {{52{a[21]}}, a[21:10]}; // repetis 52 veces el adrres mas significativo
			default: y = 0;
		endcase
		
endmodule