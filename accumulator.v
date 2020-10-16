/**
*	累加器
*/

`include "defines.v"

module accumulator(
	input  [`WORDSIZE - 1 : 0]	a,
	input  [1:0]					s,
	input 							clk,
	input								clr,
	output [`WORDSIZE - 1 : 0] result
);

wire[`WORDSIZE - 1 : 0] alu_out;
alu u_alu(
	.a(a),
	.b(result),
	.s(s),
	.y(alu_out)
);

d_ff u_d_ff(
	.d(alu_out),
	.clk(clk),
	.clr(clr),
	.q(result)
);

endmodule