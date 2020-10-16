/**
*	4-1选择器
*/

`include "defines.v"

module select4_1(
	input  [`WORDSIZE - 1 : 0]		a,
	input  [`WORDSIZE - 1 : 0]		b,
	input  [`WORDSIZE - 1 : 0]		c,
	input  [`WORDSIZE - 1 : 0]		d,
	input	 [1 : 0]						s,
	output [`WORDSIZE - 1 : 0]		y
);

wire [`WORDSIZE - 1 : 0] selector1_out;
wire [`WORDSIZE - 1 : 0] selector2_out;
/**
	00: y <= a;
	01: y <= b;
	10: y <= c;
	11: y <= d;
*/
select2_1 u_select2_1_1(
	.a(a),
	.b(c),
	.s(s[1]),
	.y(selector1_out)
);

select2_1 u_select2_1_2(
	.a(b),
	.b(d),
	.s(s[1]),
	.y(selector2_out)
);

select2_1 u_select2_1_3(
	.a(selector1_out),
	.b(selector2_out),
	.s(s[0]),
	.y(y)
);

endmodule