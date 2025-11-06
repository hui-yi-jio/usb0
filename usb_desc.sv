module usb_desc (
	input [15:0]  descrom_raddr_o       ,
	output [7:0]  descrom_rdata_i       ,
	output [15:0] desc_dev_addr_i       ,
	output [15:0] desc_dev_len_i        ,
	output [15:0] desc_qual_addr_i      ,
	output [15:0] desc_qual_len_i       ,
	output [15:0] desc_fscfg_addr_i     ,
	output [15:0] desc_fscfg_len_i      ,
	output [15:0] desc_hscfg_addr_i     ,
	output [15:0] desc_hscfg_len_i      ,
	output [15:0] desc_oscfg_addr_i     ,
	output [15:0] desc_hidrpt_addr_i    ,
	output [15:0] desc_hidrpt_len_i     ,
	output [15:0] desc_bos_addr_i       ,
	output [15:0] desc_bos_len_i        ,
	output [15:0] desc_strlang_addr_i   ,
	output [15:0] desc_strvendor_addr_i ,
	output [15:0] desc_strvendor_len_i  ,
	output [15:0] desc_strproduct_addr_i,
	output [15:0] desc_strproduct_len_i ,
	output [15:0] desc_strserial_addr_i ,
	output [15:0] desc_strserial_len_i  ,
	output desc_have_strings_i
);

    localparam [7:0]descrom[0:781] = {
	// 设备描述符 (18 bytes)
	8'h12,8'h01,8'h00,8'h02,8'hEF,8'h02,8'h01,8'h40,8'h88,8'h88,8'h77,8'h77,8'h00,8'h02,8'h01,8'h02,8'h03,8'h01,
	
	// 设备限定描述符 (10 bytes)
	8'h0a,8'h06,8'h00,8'h02,8'h02,8'h00,8'h00,8'h40,8'h01,8'h00,
	
	// === 全速配置描述符 ===
	// 配置描述符头 (9 bytes)
	8'h09,8'h02,8'h4F,8'h01,8'h09,8'h01,8'h00,8'hC0,8'hFA,
	
	// === 串口1 ===
	// IAD for Serial Port 1 (8 bytes)
	8'h08,8'h0B,8'h00,8'h02,8'h02,8'h02,8'h01,8'h04,
	// 控制接口描述符 (9 bytes)
	8'h09,8'h04,8'h00,8'h00,8'h01,8'h02,8'h02,8'h01,8'h00,
	// CDC Header (5 bytes)
	8'h05,8'h24,8'h00,8'h10,8'h01,
	// CDC Call Management (5 bytes)
	8'h05,8'h24,8'h01,8'h00,8'h01,
	// CDC ACM (4 bytes)
	8'h04,8'h24,8'h02,8'h02,
	// CDC Union (5 bytes)
	8'h05,8'h24,8'h06,8'h00,8'h01,
	// 中断端点描述符 (7 bytes)
	8'h07,8'h05,8'h81,8'h03,8'h10,8'h00,8'h01,
	// 数据接口描述符 (9 bytes)
	8'h09,8'h04,8'h01,8'h00,8'h02,8'h0A,8'h00,8'h00,8'h00,
	// 批量OUT端点描述符 (7 bytes)
	8'h07,8'h05,8'h02,8'h02,8'h40,8'h00,8'h00,
	// 批量IN端点描述符 (7 bytes)
	8'h07,8'h05,8'h82,8'h02,8'h40,8'h00,8'h00,
	
	// === 串口2 ===
	// IAD for Serial Port 2 (8 bytes)
	8'h08,8'h0B,8'h02,8'h02,8'h02,8'h02,8'h01,8'h05,
	// 控制接口描述符 (9 bytes)
	8'h09,8'h04,8'h02,8'h00,8'h01,8'h02,8'h02,8'h01,8'h00,
	// CDC Header (5 bytes)
	8'h05,8'h24,8'h00,8'h10,8'h01,
	// CDC Call Management (5 bytes)
	8'h05,8'h24,8'h01,8'h00,8'h01,
	// CDC ACM (4 bytes)
	8'h04,8'h24,8'h02,8'h02,
	// CDC Union (5 bytes)
	8'h05,8'h24,8'h06,8'h01,8'h03,
	// 中断端点描述符 (7 bytes)
	8'h07,8'h05,8'h83,8'h03,8'h10,8'h00,8'h01,
	// 数据接口描述符 (9 bytes)
	8'h09,8'h04,8'h03,8'h00,8'h02,8'h0A,8'h00,8'h00,8'h00,
	// 批量OUT端点描述符 (7 bytes)
	8'h07,8'h05,8'h04,8'h02,8'h40,8'h00,8'h00,
	// 批量IN端点描述符 (7 bytes)
	8'h07,8'h05,8'h84,8'h02,8'h40,8'h00,8'h00,
	
	// === 串口3 ===
	// IAD for Serial Port 3 (8 bytes)
	8'h08,8'h0B,8'h04,8'h02,8'h02,8'h02,8'h01,8'h00,
	// 控制接口描述符 (9 bytes)
	8'h09,8'h04,8'h04,8'h00,8'h01,8'h02,8'h02,8'h01,8'h00,
	// CDC Header (5 bytes)
	8'h05,8'h24,8'h00,8'h10,8'h01,
	// CDC Call Management (5 bytes)
	8'h05,8'h24,8'h01,8'h00,8'h01,
	// CDC ACM (4 bytes)
	8'h04,8'h24,8'h02,8'h02,
	// CDC Union (5 bytes)
	8'h05,8'h24,8'h06,8'h02,8'h05,
	// 中断端点描述符 (7 bytes)
	8'h07,8'h05,8'h85,8'h03,8'h10,8'h00,8'h01,
	// 数据接口描述符 (9 bytes)
	8'h09,8'h04,8'h05,8'h00,8'h02,8'h0A,8'h00,8'h00,8'h00,
	// 批量OUT端点描述符 (7 bytes)
	8'h07,8'h05,8'h06,8'h02,8'h40,8'h00,8'h00,
	// 批量IN端点描述符 (7 bytes)
	8'h07,8'h05,8'h86,8'h02,8'h40,8'h00,8'h00,
	
	// === 串口4 ===
	// IAD for Serial Port 4 (8 bytes)
	8'h08,8'h0B,8'h06,8'h02,8'h02,8'h02,8'h01,8'h00,
	// 控制接口描述符 (9 bytes)
	8'h09,8'h04,8'h06,8'h00,8'h01,8'h02,8'h02,8'h01,8'h00,
	// CDC Header (5 bytes)
	8'h05,8'h24,8'h00,8'h10,8'h01,
	// CDC Call Management (5 bytes)
	8'h05,8'h24,8'h01,8'h00,8'h01,
	// CDC ACM (4 bytes)
	8'h04,8'h24,8'h02,8'h02,
	// CDC Union (5 bytes)
	8'h05,8'h24,8'h06,8'h03,8'h07,
	// 中断端点描述符 (7 bytes)
	8'h07,8'h05,8'h87,8'h03,8'h10,8'h00,8'h01,
	// 数据接口描述符 (9 bytes)
	8'h09,8'h04,8'h07,8'h00,8'h02,8'h0A,8'h00,8'h00,8'h00,
	// 批量OUT端点描述符 (7 bytes)
	8'h07,8'h05,8'h08,8'h02,8'h40,8'h00,8'h00,
	// 批量IN端点描述符 (7 bytes)
	8'h07,8'h05,8'h88,8'h02,8'h40,8'h00,8'h00,
	
	// === 高速配置描述符 === (与全速相同)
	// 配置描述符头 (9 bytes)
	8'h09,8'h02,8'h4F,8'h01,8'h09,8'h01,8'h00,8'hC0,8'hFA,
	
	// === 串口1 ===
	8'h08,8'h0B,8'h00,8'h02,8'h02,8'h02,8'h01,8'h04,
	8'h09,8'h04,8'h00,8'h00,8'h01,8'h02,8'h02,8'h01,8'h04,
	8'h05,8'h24,8'h00,8'h10,8'h01,
	8'h05,8'h24,8'h01,8'h00,8'h01,
	8'h04,8'h24,8'h02,8'h02,
	8'h05,8'h24,8'h06,8'h00,8'h01,
	8'h07,8'h05,8'h81,8'h03,8'h10,8'h00,8'h01,
	8'h09,8'h04,8'h01,8'h00,8'h02,8'h0A,8'h00,8'h00,8'h00,
	8'h07,8'h05,8'h02,8'h02,8'h40,8'h00,8'h00,
	8'h07,8'h05,8'h82,8'h02,8'h40,8'h00,8'h00,
	
	// === 串口2 ===
	8'h08,8'h0B,8'h02,8'h02,8'h02,8'h02,8'h01,8'h05,
	8'h09,8'h04,8'h02,8'h00,8'h01,8'h02,8'h02,8'h01,8'h05,
	8'h05,8'h24,8'h00,8'h10,8'h01,
	8'h05,8'h24,8'h01,8'h00,8'h01,
	8'h04,8'h24,8'h02,8'h02,
	8'h05,8'h24,8'h06,8'h02,8'h03,
	8'h07,8'h05,8'h83,8'h03,8'h10,8'h00,8'h01,
	8'h09,8'h04,8'h03,8'h00,8'h02,8'h0A,8'h00,8'h00,8'h00,
	8'h07,8'h05,8'h04,8'h02,8'h40,8'h00,8'h00,
	8'h07,8'h05,8'h84,8'h02,8'h40,8'h00,8'h00,
	
	// === 串口3 ===
	8'h08,8'h0B,8'h04,8'h02,8'h02,8'h02,8'h01,8'h06,
	8'h09,8'h04,8'h04,8'h00,8'h01,8'h02,8'h02,8'h01,8'h06,
	8'h05,8'h24,8'h00,8'h10,8'h01,
	8'h05,8'h24,8'h01,8'h00,8'h01,
	8'h04,8'h24,8'h02,8'h02,
	8'h05,8'h24,8'h06,8'h04,8'h05,
	8'h07,8'h05,8'h85,8'h03,8'h10,8'h00,8'h01,
	8'h09,8'h04,8'h05,8'h00,8'h02,8'h0A,8'h00,8'h00,8'h00,
	8'h07,8'h05,8'h06,8'h02,8'h40,8'h00,8'h00,
	8'h07,8'h05,8'h86,8'h02,8'h40,8'h00,8'h00,
	
	// === 串口4 ===
	8'h08,8'h0B,8'h06,8'h02,8'h02,8'h02,8'h01,8'h07,
	8'h09,8'h04,8'h06,8'h00,8'h01,8'h02,8'h02,8'h01,8'h07,
	8'h05,8'h24,8'h00,8'h10,8'h01,
	8'h05,8'h24,8'h01,8'h00,8'h01,
	8'h04,8'h24,8'h02,8'h02,
	8'h05,8'h24,8'h06,8'h06,8'h07,
	8'h07,8'h05,8'h87,8'h03,8'h10,8'h00,8'h01,
	8'h09,8'h04,8'h07,8'h00,8'h02,8'h0A,8'h00,8'h00,8'h00,
	8'h07,8'h05,8'h08,8'h02,8'h40,8'h00,8'h00,
	8'h07,8'h05,8'h88,8'h02,8'h40,8'h00,8'h00,
	
	// 其他速度配置描述符 (7 bytes)
	8'h07,8'h0B,8'h4F,8'h01,8'h09,8'h01,8'h00,
	

	// HID报告描述符 (21 bytes)
	8'h09,8'h21,8'h11,8'h01,8'h00,8'h01,8'h22,8'h34,8'h00,
	8'h05,8'h0F,8'h16,8'h00,8'h02,
	8'h07,8'h10,8'h02,8'h02,8'h00,8'h00,8'h00,
	
	// BOS描述符 (24 bytes)
	8'h18,8'h10,8'h05,8'h00,8'h88,8'hB6,8'h42,8'h84,8'h0C,8'hBF,8'h4D,8'hC0,8'h9C,8'h2D,8'h65,8'h2F,8'h2A,8'hF2,8'h9C,8'h8C,8'h00,8'h00,8'h01,8'h00,
	
	// 字符串描述符
	// 语言ID (4 bytes)
	8'h04,8'h03,8'h09,8'h04,
	// 厂商字符串 (38 bytes)
	8'h26,8'h03,8'h55,8'h00,8'h53,8'h00,8'h42,8'h00,8'h54,8'h00,8'h6F,8'h00,8'h55,8'h00,8'h41,8'h00,8'h52,8'h00,8'h54,8'h00,8'h49,8'h00,8'h32,8'h00,8'h43,8'h00,8'h53,8'h00,8'h50,8'h00,8'h49,8'h00,8'h50,8'h00,8'h57,8'h00,8'h4D,8'h00,
	// 产品字符串 (12 bytes)
	8'h0c,8'h03,8'h34,8'h00,8'h50,8'h00,8'h6F,8'h00,8'h72,8'h00,8'h74,8'h00,
	// 序列号字符串 (28 bytes)
	8'h1c,8'h03,8'h30,8'h00,8'h30,8'h00,8'h30,8'h00,8'h30,8'h00,8'h30,8'h00,8'h30,8'h00,8'h30,8'h00,8'h30,8'h00,8'h30,8'h00,8'h30,8'h00,8'h30,8'h00,8'h30,8'h00,8'h31,8'h00,
// 串口1名称: USBtoUART (20 bytes)
	8'h14,8'h03,8'h55,8'h00,8'h53,8'h00,8'h42,8'h00,8'h74,8'h00,8'h6F,8'h00,8'h55,8'h00,8'h41,8'h00,8'h52,8'h00,8'h54,8'h00,
	// 串口2名称: USBtoI2C (16 bytes)
	8'h10,8'h03,8'h55,8'h00,8'h53,8'h00,8'h42,8'h00,8'h74,8'h00,8'h6F,8'h00,8'h49,8'h00,8'h32,8'h00,8'h43,8'h00,
	// 串口3名称: USBtoSPI (16 bytes)
	8'h10,8'h03,8'h55,8'h00,8'h53,8'h00,8'h42,8'h00,8'h74,8'h00,8'h6F,8'h00,8'h53,8'h00,8'h50,8'h00,8'h49,8'h00,
	// 串口4名称: USBtoPWM (16 bytes)
	8'h10,8'h03,8'h55,8'h00,8'h53,8'h00,8'h42,8'h00,8'h74,8'h00,8'h6F,8'h00,8'h50,8'h00,8'h57,8'h00,8'h4D,8'h00
	}; 
    
    assign  desc_dev_addr_i        = 0;    // 0-17: 18字节
    assign  desc_dev_len_i         = 18;
    assign  desc_qual_addr_i       = 18;   // 18-27: 10字节
    assign  desc_qual_len_i        = 10;
    assign  desc_fscfg_addr_i      = 28;   // 28-300: 273字节
    assign  desc_fscfg_len_i       = 273;
    assign  desc_hscfg_addr_i      = 301;  // 301-573: 273字节
    assign  desc_hscfg_len_i       = 273;
    assign  desc_oscfg_addr_i      = 574;  // 574-580: 7字节
    // 其他速度配置描述符：7字节
    assign  desc_hidrpt_addr_i     = 581;  // 581-601: 21字节
    assign  desc_hidrpt_len_i      = 21;
    assign  desc_bos_addr_i        = 602;  // 602-625: 24字节
    assign  desc_bos_len_i         = 24;
    assign  desc_strlang_addr_i    = 626;  // 626-629: 4字节
    assign  desc_strvendor_addr_i  = 630;  // 630-667: 38字节
    assign  desc_strvendor_len_i   = 38;
    assign  desc_strproduct_addr_i = 668;  // 668-679: 12字节
    assign  desc_strproduct_len_i  = 12;
    assign  desc_strserial_addr_i  = 680;  // 680-707: 28字节
    assign  desc_strserial_len_i   = 28;
    assign  desc_have_strings_i    = 1;
    assign  descrom_rdata_i        = descrom[descrom_raddr_o];
    
endmodule
