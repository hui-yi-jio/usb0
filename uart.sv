module uart(
	input clk,
	input txact,txpop,
	input [3:0]endpt,
	output reg txval,txcork,
	output reg [7:0]txdat,
	output reg [11:0]txdat_len,
	input rxact,rxval,
	output reg rxrdy,
	input reg [7:0]rxdat,
	input adcclk,
	input [7:0]data
);
reg [5:0]i = 'b0;
reg [7:0][0:63]tmp;
	always@ (posedge clk)begin
		rxrdy <= 1;
		//if(rxact && rxval)begin
		//	i <= i + 1;
		//	tmp[i] <= rxdat;
		//end
		//else rxrdy <= 0;
		//if(txact)begin
			txcork <= 0;
	      		txdat <= tmp[0];
	      		txdat_len <= 1;
		//end
		//else txcork <= 1;
	end
	always @(negedge adcclk)begin
		tmp[0] <= data;
	end
endmodule
