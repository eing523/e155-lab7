/////////////////////////////////////////////
// subbytes
//   
//   Section 5.1.1, Figure 7
/////////////////////////////////////////////
module subbytes(
	input  logic [127:0]   a, 
	input  logic 		  clk,
	output logic [127:0]  y);

  // S-boxes for Column 0 
  sbox_sync sbox16(.a(a[127:120]), .clk(clk), .y(y[127:120]));
  sbox_sync sbox15(.a(a[119:112]), .clk(clk), .y(y[119:112]));
  sbox_sync sbox14(.a(a[111:104]), .clk(clk), .y(y[111:104]));
  sbox_sync sbox13(.a(a[103:96]), .clk(clk), .y(y[103:96]));

  // S-boxes for Column 1 
  sbox_sync sbox12(.a(a[95:88]), .clk(clk), .y(y[95:88]));
  sbox_sync sbox11(.a(a[87:80]), .clk(clk), .y(y[87:80]));
  sbox_sync sbox10(.a(a[79:72]), .clk(clk), .y(y[79:72]));
  sbox_sync sbox9(.a(a[71:64]),  .clk(clk), .y(y[71:64]));

  // S-boxes for Column 2 
  sbox_sync sbox8(.a(a[63:56]), .clk(clk), .y(y[63:56]));
  sbox_sync sbox7(.a(a[55:48]), .clk(clk), .y(y[55:48]));
  sbox_sync sbox6(.a(a[47:40]), .clk(clk), .y(y[47:40]));
  sbox_sync sbox5(.a(a[39:32]), .clk(clk), .y(y[39:32]));

  // S-boxes for Column 3
  sbox_sync sbox4(.a(a[31:24]), .clk(clk), .y(y[31:24]));
  sbox_sync sbox3(.a(a[23:16]), .clk(clk), .y(y[23:16]));
  sbox_sync sbox2(.a(a[15:8]), .clk(clk), .y(y[15:8]));
  sbox_sync sbox1(.a(a[7:0]), .clk(clk), .y(y[7:0]));
  
  
endmodule