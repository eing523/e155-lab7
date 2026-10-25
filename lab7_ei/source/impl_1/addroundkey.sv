/////////////////////////////////////////////
// addroundkey
//   transformation of the state (the 4x4 array s),
// in which a round key is combined with the state using XOR
//   Section 5.1.4, Figure 5
/////////////////////////////////////////////

//TODOOOO 


module addroundkey(
	input		logic [7:0] a,
	input logic [127:0] key,
	input logic [127:0] round_key,
	input	 	logic 			clk,
	output 	logic [127:0] y);
   
   genvar i;
   
	   
   for (i = 0; i <= Nr; i++) begin
	assign y[0][i][7:0] = [31:0]round_key ^ yarray;
	
	
endmodule
