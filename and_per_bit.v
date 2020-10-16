/**
*	按位与
*/

`include "defines.v"

module and_per_bit(
	input  [`WORDSIZE-1 : 0] a,
	input  [`WORDSIZE-1 : 0] b,
	output [`WORDSIZE-1 : 0] y
);

genvar i;

generate
	
	for (i = 0; i < `WORDSIZE; i = i + 1)
		begin: and_per_bit_loop
			and u_and(y[i], a[i], b[i]);
		end

endgenerate

endmodule