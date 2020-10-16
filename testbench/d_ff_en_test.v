`timescale 1ns/1ps
`include "../defines.v"
module d_ff_en_test;

reg clk;
reg clr;
reg en;
reg[`WORDSIZE - 1 : 0] d;
wire[`WORDSIZE - 1 : 0] q;
d_ff_en u_d_ff_en(
	.d(d),
	.clk(clk),
	.clr(clr),
	.en(en),
	.q(q)
);

initial

begin
//	clr = 0; 
//	#1;
//	clr=1;clk =0;
	clk=0;
	#1;
	clk = 1;
	#1;
	clk=0;
	d = 21;en=0;
	#1;
	clk=1;
	#1;
	en=1;
	clk = 0;
	#1;
	clk = 1;
	#1;
	
	
	

	
end

endmodule