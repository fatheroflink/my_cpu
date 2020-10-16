/**
*	比较器
*/

module comparator(
	input [`WORDSIZE - 1 : 0] a,
	input [`WORDSIZE - 1 : 0] b,
	output y
);

//genvar i;
//generate
//for (i = 0; i < `WORDSIZE; i = i + 1)
//	begin
//		
//	end
//endgenerate

assign y = a == b;

endmodule