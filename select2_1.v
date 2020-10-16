/**
*	2-1选择器
*/

`include "defines.v"

module select2_1(
	input  [`WORDSIZE - 1 : 0]		a,
	input  [`WORDSIZE - 1 : 0]		b,
	input									s,
	output [`WORDSIZE - 1 : 0]		y
);


wire s_n;
not u_not(s_n, s);

genvar i;
generate

for (i = 0; i < `WORDSIZE; i = i + 1)
	begin: select2_1_loop
		wire and1_out;
		wire and2_out;

		and u_and1(and1_out, s_n, a[i]);
		and u_and2(and2_out, s, b[i]);
		or u_or(y[i], and1_out, and2_out);
	end
endgenerate
endmodule