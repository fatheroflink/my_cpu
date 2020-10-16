/**
*	测试平台
*/

`include "defines.v"

module test;

reg [`WORDSIZE - 1 : 0] a;
reg [`WORDSIZE - 1 : 0] b;

reg [1:0] s;

wire [`WORDSIZE - 1 : 0] y;

alu u_alu( 
	.a(a),
	.b(b),
	.s(s),
	.y(y)
);

initial 
	begin
		a = `WORDSIZE'b1;
		b = `WORDSIZE'b1;
		s = 2'b00;
		#100;
		s = 2'b01;
		#100;
		s = 2'b10;
		#100;
		s = 2'b11;
		#100;
		
		a = `WORDSIZE'b1;
		b = `WORDSIZE'b0;
		s = 2'b00;
		#100;
		s = 2'b01;
		#100;
		s = 2'b10;
		#100;
		s = 2'b11;
		#100;
		
		a = `WORDSIZE'b0;
		b = `WORDSIZE'b1;
		s = 2'b00;
		#100;
		s = 2'b01;
		#100;
		s = 2'b10;
		#100;
		s = 2'b11;
		#100;
		
		a = `WORDSIZE'b0;
		b = `WORDSIZE'b0;
		s = 2'b00;
		#100;
		s = 2'b01;
		#100;
		s = 2'b10;
		#100;
		s = 2'b11;
		#100;
	end
	
endmodule