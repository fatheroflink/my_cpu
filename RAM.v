/**
*	RAM模块
*/

`include "defines.v"

module RAM(
	input  [`WORDSIZE - 1 : 0] data_in,
	input  [`WORDSIZE - 1 : 0] addr,
	input								clk,
	input 							write_en,
	output [`WORDSIZE - 1 : 0] data_out
);

wire [3:0] decoder_out;
wire [3:0] register_clk;
wire [3:0] register_out;

decoder2_4 u_decoder2_4(
	.addr(addr),
	.y(decoder_out)
);

and u_and0(register_clk[0], decoder_out[0], write_en, clk);
and u_and1(register_clk[1], decoder_out[1], write_en, clk);
and u_and2(register_clk[2], decoder_out[2], write_en, clk);
and u_and3(register_clk[3], decoder_out[3], write_en, clk);

d_ff u_d_ff0(
	.d(data_in),
	.clk(clk),
	.clr(clr),
	.q(register_out[0])
);

d_ff u_d_ff1(
	.d(data_in),
	.clk(clk),
	.clr(clr),
	.q(register_out[1])
);

d_ff u_d_ff2(
	.d(data_in),
	.clk(clk),
	.clr(clr),
	.q(register_out[2])
);

d_ff u_d_ff3(
	.d(data_in),
	.clk(clk),
	.clr(clr),
	.q(register_out[3])
);

select4_1 u_select4_1(
	.a(register_out[0]),
	.b(register_out[1]),
	.c(register_out[2]),
	.d(register_out[3]),
	.s(addr),
	.y(data_out)
);
endmodule