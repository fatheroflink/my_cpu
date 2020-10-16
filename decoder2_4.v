/**
*	2-4译码器
*/

module decoder2_4(
	input [1:0] addr,
	output [3:0]	y
);

wire a0_n;
wire a1_n;

assign a0 = addr[0];
assign a1 = addr[1];
not u_not0(a0_n, a0);
not u_not1(a1_n, a1);

and u_and0(y[0], a0_n, a1_n);
and u_and1(y[1], a0, a1_n);
and u_and2(y[2], a0_n, a1);
and u_and3(y[3], a0, a1);

endmodule