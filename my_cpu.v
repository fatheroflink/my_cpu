/**
*	顶层模块
*/

`timescale 1ns/1ps
`include "defines.v"
module my_cpu
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


//RAM初始化

/**
	时钟与复位信号定义
*/
wire clock;		//测试用时钟，非晶振产生
wire reset;		//测试用复位
wire reset_n;
assign clock = ~key1;
assign reset = ~key0;
assign reset_n = ~reset;

wire init_clock;	//用于初始化RAM的时钟信号
wire init_reset;	//用于初始化RAM的复位信号
assign init_clock = clk;
assign init_reset = ~key0;

/**
	初始化RAM所用到的变量
*/
reg [`WORDSIZE - 1 : 0] initial_addr;	//初始化RAM时所用地址信号
reg [`WORDSIZE - 1 : 0] init_data_in;		//初始化RAM时所用的数据输入信号

reg[3:0] counter;		//初始化RAM时所用的计数器
parameter MAX_COUNTER = 5;	//初始化RAM时需为多少个地址赋值

/**
	RAM相关变量
*/
wire [`WORDSIZE - 1 : 0] result;		//RAM的输出信号
reg write_en;								//RAM的写使能信号
reg [`WORDSIZE - 1 : 0] addr;			//RAM的地址信号
reg ram_clock;

/**
	ALU相关变量
*/
wire[`WORDSIZE - 1 : 0] alu_a;		//ALU的输入a
wire[`WORDSIZE - 1 : 0] alu_out;		//ALU的输出


assign led[1:0] = addr;
assign led[3:2] = counter;

assign led_out[7:0] = init_data_in;
assign led_out[15:8] = result;

//当初始化RAM完成后，令addr为自定义输入，否则为initial_addr

always@(*)
	begin
		if (counter < MAX_COUNTER)
			begin
				addr = initial_addr;
				ram_clock = init_clock;
			end
		else
			begin
				addr = {~key2, ~key3};
				ram_clock = clock;
			end
	end

always @(posedge init_clock or posedge init_reset)
	begin
		if (init_reset)
			counter <= 0;
		else
			begin
				if (counter < MAX_COUNTER)
					counter <= counter + 1;
				else
					counter <= counter;
			end
	end

	
always@(posedge init_clock or posedge init_reset )
	begin
		if (init_reset)
			begin
				initial_addr <= 0;
				write_en <= 1;
			end
		else 
			begin
				case(counter)
					0: begin
							initial_addr <= 0;
							init_data_in <= 74;
						end
						
					1: begin
							initial_addr <= 1;
							init_data_in <= 29;
						end
					 
					2: begin
							initial_addr <= 2;
							init_data_in <= 32;
						end
						
					3: begin
							initial_addr <= 3;
							init_data_in <= 20;
						end
					default:
						write_en <= 0;
					
				endcase
			end
	end
	

	
	
RAM4_8 u_ram4_8(
	.data_in(init_data_in),
	.addr(addr),
	.clk(ram_clock),
	.write_en(write_en),
	.data_out(result)
);

digits_show u_digits_show(
	.in(alu_a),
	.clk(clk),
	.seg_sel(seg_sel),
	.seg_data(seg_data)
);

alu u_alu( 
	.a(alu_a),
	.b(result),
	.s(2'b00),
	.y(alu_out)
);

d_ff_en u_acc(
	.d(alu_out),
	.clk(~key1),
	.clr(~key0),
	.en(1),
	.q(alu_a)
);





endmodule