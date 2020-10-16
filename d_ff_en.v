/**
*	带使能端的D触发器
*/
`timescale 1ns/100ps
`include "defines.v"

module d_ff_en(
	input  [`WORDSIZE - 1 : 0]  	d,
	input 							 	clk,
	input								 	clr,
	input								 	en,
	output [`WORDSIZE - 1 : 0]	 	q
);
wire[`WORDSIZE - 1 : 0] select2_1out;
wire[`WORDSIZE - 1 : 0] d_ff_out;

d_ff u_d_ff(
	.d(select2_1out),
	.clk(clk),
	.clr(clr),
	.q(d_ff_out)
);

select2_1 u_select2_1(
	.a(d_ff_out),
	.b(d),
	.s(en),
	.y(select2_1out)
);
assign q = d_ff_out;
//wire [`WORDSIZE - 1 : 0] d_ff_out;
//wire [`WORDSIZE - 1 : 0] d_tmp;
//d_ff u_d_ff(
//	.d(d_tmp),
//	.clk(clk),
//	.clr(clr),
//	.q(d_ff_out)
//);
//always@(en)
//	begin
//		if (en)
//			d_tmp <= d
//		else
//			d_tmp <= d_ff_out;
//	end
endmodule