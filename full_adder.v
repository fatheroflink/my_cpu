/**
*	全加器
*/

module full_adder(
	input a,
	input b,
	input c_in,		// 进位输入
	output s,	// 加和输出
	output c_out	// 进位输出
);

wire s1;
wire c_out1;

wire c_out2;

half_adder h1(
	.a(a),
	.b(b),
	.s(s1),
	.c_out(c_out1)
);

half_adder h2(
	.a(c_in),
	.b(s1),
	.s(s),
	.c_out(c_out2)
);

assign c_out = c_out1 | c_out2;

endmodule
