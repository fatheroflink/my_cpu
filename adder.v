/**
*	加法器
*/

`include "defines.v"


module adder(
	input  [`WORDSIZE - 1 : 0] a,
	input  [`WORDSIZE - 1 : 0] b,
	input  is_minus,
	output [`WORDSIZE - 1 : 0] s,
	output c_out
);

wire [`WORDSIZE - 1 : 0] b_in_list;
wire [`WORDSIZE - 1 : 0] c_out_list;

genvar i;

generate
	
	for (i = 0; i < `WORDSIZE; i = i + 1)
		begin: xor_loop
			xor x(b_in_list[i], b[i], is_minus);
		end
		
endgenerate

generate
	
	for (i = 0; i < `WORDSIZE; i = i + 1)
		begin: full_adder_loop
			full_adder f(
				.a(a[i]),
				.b(b_in_list[i]),
				.c_in(i == 0 ? is_minus : c_out_list[i-1]),
				.s(s[i]),
				.c_out(c_out_list[i])
			);
		end
	

endgenerate

endmodule