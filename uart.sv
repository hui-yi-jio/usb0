module uart(
	input clk,
	input txact,txpop,
	input [3:0]endpt,
	output reg txval,txcork,
	output reg [7:0]txdat,
	output reg [11:0]txdat_len,
	input rxact,rxval,
	output reg rxrdy,
	input reg [7:0]rxdat
);
wire [5:0]compare;
reg [5:0]ri = 'b0;
reg [5:0]ti = 'b0;
reg [7:0][0:63]tmp;
assign compare = ri-ti;
	always@ (posedge clk)begin
		txcork <= 0;//compare ? 0 : 1;
		if(txact)begin
			txdat <= ri;//tmp[ti];
			txdat_len <= 1;
			ti <= ti + 1;
		end
		rxrdy <= 1;
			
		if(rxact && rxval && (endpt==0))begin
			ri <= ri + 1;
			tmp[ri] <= rxdat;
		end
	end
endmodule
