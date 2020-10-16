/**
*	按位或
*/

`include "defines.v"

module or_per_bit(
	input  [`WORDSIZE-1 : 0] a,
	input  [`WORDSIZE-1 : 0] b,
	output [`WORDSIZE-1 : 0] y
);

genvar i;

generate
	
	for (i = 0; i < `WORDSIZE; i = i + 1)
		begin: or_per_bit_loop
			or u_or(y[i], a[i], b[i]);
		end

endgenerate

endmodule