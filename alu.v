/**
*	ALU
*/

`include "defines.v"

module alu(
	input  [`WORDSIZE - 1 : 0]	a,
	input  [`WORDSIZE - 1 : 0]	b,
	input  [1 : 0]					s,
	output [`WORDSIZE - 1 : 0] y	
);

wire c_in;
wire c_out;

wire [`WORDSIZE - 1 : 0] adder_output;
wire [`WORDSIZE - 1 : 0] and_per_bit_output;
wire [`WORDSIZE - 1 : 0] or_per_bit_output;

adder u_adder(
	.a(a),
	.b(b),
	.is_minus(s[0]),
	.s(adder_output),
	.c_out(c_out)
);

and_per_bit u_and_per_bit(
	.a(a),
	.b(b),
	.y(and_per_bit_output)
);

or_per_bit u_or_per_bit(
	.a(a),
	.b(b),
	.y(or_per_bit_output)
);

select4_1 u_select4_1(
	.a(adder_output),
	.b(adder_output),
	.c(and_per_bit_output),
	.d(or_per_bit_output),
	.s(s),
	.y(y)
);

endmodule