module imem(input logic [7:0] addr, output logic [31:0] q);

	logic [31:0] rom [0:255] = '{default: 32'h0};

	initial begin
//		CODIGO PROPIO PARA PROBAR ADDI Y SUBI		//
		rom [0 : 20] = '{
			32'h910028a3, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8000003, //add x3, x5, #0xa4 ; stur    x3, [x0] => x3 = 15
			32'hd1001544, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8008004 , //  sub    x4, x10, #0x5 ; stur    x4, [x0, #8] => x4 = 5
			32'hd1004063, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8000203, //  sub    x3, x3, #0x10 ;   stur    x3, [x16] => x3 = -1
			32'h91000863, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8008203, //  add    x3, x3, #0x2 ; stur    x3, [x16, #8] => x3 = 1
			
			32'hb400001f 
		};	
//		CODIGO DE LA CATEDRA			//
//	rom [0:147] ='{ 32'hf8000001,
//		 32'hf8008002, 32'hf8000203, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h91001483,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8018003, 32'hd1001483, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8020003, 32'hcb0a03e4, 32'h8b1f03ff, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'hf8028004, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b040064,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8030004, 32'hcb030025,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8038005, 32'h8a1f0145,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8040005, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8a030145, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'hf8048005, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8a140294,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8050014, 32'haa1f0166,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8058006, 32'haa030166,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8060006, 32'hf840000c,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f0187, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8068007, 32'hf807000c, 32'h8b0e01bf,
//		 32'hf807801f, 32'hb4000100, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff,
//		 32'hf8080015, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8088015, 32'h8b0103e2, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hcb010042, 32'h8b0103f8, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf8090018, 32'h8b080000, 32'hb4ffff02,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf809001e, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1e03de, 32'hcb1503f5, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1403de, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'hf85f83d9, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff,
//		 32'h8b1e03de, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1003de,
//		 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'h8b1f03ff, 32'hf81f83d9, 32'h8b1f03ff,
//		 32'h8b1f03ff, 32'hb4ffffdf, 32'hb400001f};
	end

	
					
	always_comb begin
		q = rom[addr];
	end
					
endmodule