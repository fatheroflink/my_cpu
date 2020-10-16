`timescale 1ns/1ps
`include "../defines.v"
module ram_init_test;

reg key2, key3;

reg clock;
reg reset;

wire init_clock;	//用于初始化RAM的时钟信号
wire init_reset;	//用于初始化RAM的复位信号

assign init_clock = clock;
assign init_reset = reset;
/**
	初始化RAM所用到的变量
*/
reg [`WORDSIZE - 1 : 0] initial_addr;	//初始化RAM时所用地址信号
reg [`WORDSIZE - 1 : 0] init_data_in;		//初始化RAM时所用的数据输入信号

reg[3:0] counter;		//初始化RAM时所用的计数器
parameter INIT_TIMES = 4;	//初始化RAM时需为多少个地址赋值

/**
	RAM相关变量
*/
wire [`WORDSIZE - 1 : 0] result;		//RAM的输出信号
reg write_en;								//RAM的写使能信号
reg [`WORDSIZE - 1 : 0] addr;			//RAM的地址信号
reg ram_clock;


//当初始化RAM完成后，令addr为自定义输入，否则为initial_addr

always@(*)
	begin
		if (counter <= INIT_TIMES)
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
				if (counter <= INIT_TIMES)
					counter <= counter + 1;
				else
					counter <= counter;
			end
	end

always@(posedge init_clock or posedge init_reset )
	begin
		if (init_reset)
			write_en <= 0;
		else
			begin
				if (counter < INIT_TIMES)
					write_en <= 1;
				else
					write_en <= 0;
			end
	end


	
always@(posedge init_clock or posedge init_reset )
	begin
		if (init_reset)
			begin
				initial_addr <= 0;
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
//					default:
//						begin
//							initial_addr <= 4;
//						end
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

		
integer i;



initial

begin
	reset = 0; 
	#1;
	reset=1;clock =0;
	#1;
	reset = 0;
	
	for (i = 0; i < 12; i=i+1)
		begin
			clock = ~clock;
			#1;
		end
		
	key2 = 1; key3=1;
	#1;
	key2 = 1; key3=0;
	#1;
	key2 = 0; key3=1;
	#1;
	key2 = 0; key3=0;
	#1;
	
end

endmodule