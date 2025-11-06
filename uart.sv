module uart(
	input clk,
	input txact,txpop,
	input [3:0]endpt,
	output txval,txcork,
	output reg [7:0]txdat,
	output reg [11:0]txdat_len,
	input rxact,rxval,
	output rxrdy,
	input reg [7:0]rxdat,
	output pwm1,pwm2
);
reg [7:0]tmp;
reg [5:0]div;
reg [31:0]period_count,duty_count;
wire [6:0]fre,duty;
reg [31:0]fre_cnt,fre_count;
assign txcork = 0;
assign txval = 0;
assign rxrdy = 1;
assign fre = tmp[7]?tmp[6:0]:fre;
assign duty = tmp[7]?duty:tmp[6:0];
assign fre_count = 1000/fre;
assign duty_count = (fre_count*duty)/100;
assign pwm1 = fre_cnt<duty_count?1:0;
assign pwm2 = pwm1;
	always @(posedge txact)begin
		txdat <= tmp;
		txdat_len <= 1;
	end
	always @(posedge rxval)begin
		tmp <= rxdat;
	end
	always @(posedge clk)begin
		div = div + 1;
		if(div == 50)begin
			if(fre_cnt >= fre_count - 1)
				fre_cnt <= 0;
			else fre_cnt <= fre_cnt + 1;
		end
	end
endmodule
