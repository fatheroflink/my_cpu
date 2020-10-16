
`timescale 1ns/100ps
`include "defines.v"

module ram_test;

reg write_en;
reg c;
reg [`WORDSIZE - 1 : 0] data_in;
reg [`WORDSIZE - 1 : 0] addr;

wire [`WORDSIZE - 1 : 0] result;

RAM64_8 u_ram64_8(
	.data_in(data_in),
	.addr(addr),
	.clk(c),
	.write_en(write_en),
	.data_out(result)
);

//d_ff u_d_ff(
//	.d(data_in),
//	.clk(c),
//	.clr(0),
//	.q(result)
//);

//reg clr;
//always@(posedge c or posedge clr) 
//begin
//	if (clr) 
//		result <= 0;
//	else 
//		result <= data_in;
//end

//d_latch u_d_latch(
//	.d(data_in),
//	.clk(c),
//	.clr(0),
//	.q(result)
//);
initial

	begin
		data_in = 10;addr = 0;write_en = 1;c = 1'b0;
		
		#100; 
		
		c=1;
		
		#100;
		c = 0; data_in = 12;addr = 1;
		
		#100; 
		
		c=1;
		
		#100;
		
		c = 0;data_in = 2;addr = 2;
		
		#100; 
		
		c=1;
		
		#100;
		
		c = 0;data_in = 3;addr = 3;
		
		#100; 
		
		c=1'b1;
		
		#100;
		
		addr = 0;write_en = 0;
		
		#100;
		
		addr = 1;write_en = 0;
		
		#100;
		
		addr = 2;write_en = 0;
		
		#100;
		
		addr = 3;write_en = 0;
		
		#100;
//	
//	c=0;data_in = 11;
//	#100;
//	c=1;
//	#100;
//	c = 0;data_in = 12;
//	#100;
//	c = 1;
//	#100;
//	c=0;data_in = 18;
//	#100;
//	c = 1;
//	#100;
	end

endmodule