/**
*	顶层模块
*/

`timescale 1ns/1ps
`include "defines.v"
module my_top
(
	input 			key0,
	input 			key1,
	input 			key2,
	input 			key3,
	input 			clk,
	input  [3:0]	key_in_y,
	output [3:0]	key_out_x,
	output [3:0] 	led,
	output [5:0]   seg_sel,
   output [7:0]	seg_data,
	output [15:0]	led_out
	//output 			c_out
);

wire [16:1] keys;	//矩阵键盘的16个按键
key_converter u_key_converter(
	.clk(clk),
	.rst_n(key0),
	.key_in_y(key_in_y),
	.key_out_x(key_out_x),
	.keys(keys)
);



reg [`WORDSIZE-1:0] d_in;
wire [`WORDSIZE - 1 : 0] q_out;

//d_ff_en u_acc(
//	.d(d_in),
//	.clk(~key1),
//	.clr(~key0),
//	.en(1),
//	.q(q_out)
//);

reg [`WORDSIZE - 1 :0] addr;
reg write_en;
RAM4_8 u_ram4_8(
	.data_in(d_in),
	.addr(addr),
	.clk(~key1),
	.write_en(write_en),
	.data_out(q_out)
);

reg [3:0] counter;
always @(posedge ~key1 or posedge ~key0)
	if (~key0)
		counter <= 0;
	else
		begin
			if (counter <= 4)
				counter = counter + 1;
			else 
				counter <= counter;
		end

always@(posedge ~key1 or posedge ~key0)
	if (~key0)
		begin
			d_in <= 0;
			addr <= 0;
			write_en <= 1;
		end
	else
		begin
			case(counter) 
				0:begin
						d_in <= 74;
						addr <= 0;
					end
				1:begin
						d_in <= 29;
						addr <= 1;
					end
				2:begin
						d_in <= 32;
						addr <= 2;
					end
				3:begin
						d_in <= 20;
						addr <= 3;
					end
				4:begin
						addr <= 0;
						write_en = 0;
					end
				5:begin
						addr <= 1;
					end
				6:begin
						addr <= 2;
					end
				7:begin
						addr <= 3;
					end
			endcase
		end
	

digits_show u_digits_show(
	.in(q_out),
	.clk(clk),
	.seg_sel(seg_sel),
	.seg_data(seg_data)
);


endmodule