/**
*	8 * 8 RAM模块
*/
`include "defines.v"
`define ADDR_SIZE 3

module RAM8_8(
	input  [`WORDSIZE - 1 : 0] data_in,
	input  [`ADDR_SIZE - 1 : 0] addr,
	input								clk,
	input 							write_en,
	output [`WORDSIZE - 1 : 0] data_out
);

wire[`WORDSIZE - 1:0] ram1_out;
wire[`WORDSIZE - 1:0] ram2_out;
wire new_addr;
wire new_addr_n;
wire write_en1;
wire write_en2;

assign new_addr = addr[`ADDR_SIZE - 1];
not u_not(new_addr_n, new_addr);
and u_and1(write_en1, new_addr_n, write_en);
and u_and2(write_en2, new_addr, write_en);

RAM4_8 u_RAM4_8_1(
	.data_in(data_in),
	.addr(addr[`ADDR_SIZE - 2:0]),
	.clk(clk),
	.write_en(write_en1),
	.data_out(ram1_out)
);

RAM4_8 u_RAM4_8_2(
	.data_in(data_in),
	.addr(addr[`ADDR_SIZE - 2:0]),
	.clk(clk),
	.write_en(write_en2),
	.data_out(ram2_out)
);

select2_1 u_select2_1(
	.a(ram1_out),
	.b(ram2_out),
	.s(new_addr),
	.y(data_out)
);
endmodule