/**
*	4 * 8 RAM模块
*/

`include "defines.v"
`define ADDR_SIZE 2

module RAM4_8(
	input  [`WORDSIZE - 1 : 0] data_in,
	input  [`ADDR_SIZE - 1 : 0] addr,
	input								clk,
	input 							write_en,
	output [`WORDSIZE - 1 : 0] data_out
);

wire clr;
assign clr = 0;
wire [3:0] decoder_out;
wire [3:0] reg_en;
wire [`WORDSIZE - 1:0] register_out0;
wire [`WORDSIZE - 1:0] register_out1;
wire [`WORDSIZE - 1:0] register_out2;
wire [`WORDSIZE - 1:0] register_out3;

decoder2_4 u_decoder2_4(
	.addr(addr),
	.y(decoder_out)
);

and u_and0(reg_en[0], decoder_out[0], write_en);
and u_and1(reg_en[1], decoder_out[1], write_en);
and u_and2(reg_en[2], decoder_out[2], write_en);
and u_and3(reg_en[3], decoder_out[3], write_en);

d_ff_en u_d_ff0(
	.d(data_in),
	.clk(clk),
	.clr(clr),
	.en(reg_en[0]),
	.q(register_out0)
);

d_ff_en u_d_ff1(
	.d(data_in),
	.clk(clk),
	.clr(clr),
	.en(reg_en[1]),
	.q(register_out1)
);

d_ff_en u_d_ff2(
	.d(data_in),
	.clk(clk),
	.clr(clr),
	.en(reg_en[2]),
	.q(register_out2)
);

d_ff_en u_d_ff3(
	.d(data_in),
	.clk(clk),
	.clr(clr),
	.en(reg_en[3]),
	.q(register_out3)
);

select4_1 u_select4_1(
	.a(register_out0),
	.b(register_out1),
	.c(register_out2),
	.d(register_out3),
	.s(addr),
	.y(data_out)
);
endmodule