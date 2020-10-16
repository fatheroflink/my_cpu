/**
*	D触发器
*/
`timescale 1ns/100ps
`include "defines.v"

module d_ff(
	input  [`WORDSIZE - 1 : 0] 	d,
	input 							 clk,
	input								 clr,
	output [`WORDSIZE - 1 : 0]		q
);

wire [`WORDSIZE - 1 : 0] d1_out;

wire clk_n ;
not u_not(clk_n, clk);

d_latch d1(
	.d(d),
	.clk(clk_n),
	.clr(clr),
	.q(d1_out)
);

d_latch d2(
	.d(d1_out),
	.clk(clk),
	.clr(clr),
	.q(q)
);

endmodule