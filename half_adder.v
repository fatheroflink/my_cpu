/**
*	半加器
*/

module half_adder(
	input a,		
	input b,
	output s,	// 加和输出
	output c_out	// 进位输出
);

assign s = a ^ b;
assign c_out = a & b;

endmodule