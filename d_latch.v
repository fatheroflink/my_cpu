/**
*	D锁存器
*/

`include "defines.v"

module d_latch(
	input  [`WORDSIZE - 1 : 0]	   d,
	input 							 clk,
	input 							 clr,
	output [`WORDSIZE - 1 : 0]	   q
);

//wire [`WORDSIZE - 1 : 0] a;
//
//
//wire clr_n;
//not u_n(clr_n, clr);
//
//genvar i;
//
//generate
//	for(i = 0; i < `WORDSIZE; i = i + 1)
//		begin: d_latch_loop
//			and u_and(q[i], a[i], clr_n);
//		end
//endgenerate
//
//select2_1 u_select2_1(
//			.a(q),
//			.b(d),
//			.s(clk),
//			.y(a)
//		);


reg [`WORDSIZE - 1 : 0] a;
assign q = a;
always @(clk or clr or d)
begin
	if (clr)
		a = 0;
	else if (clk) 
		a = d;
end

endmodule