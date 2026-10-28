`timescale 10ns/1ns

/////////////////////////////////////////////
// state_to_output
//   Only needed if you want to use the state array inside shiftrows.
//   Paste the body of your state_to_output from Exercise 1 here.
//   If you work on the 128-bit vector directly, leave this file alone.
/////////////////////////////////////////////

module state_to_output #(parameter COL=4) (input  logic [0:3][0:COL-1][7:0] a,
                       output logic [(COL*32)-1:0]         y);
	
	genvar i;
	
	// inverse of input_to_state
	for (i=0; i<COL; i++) begin
		assign y[((COL-1-i)*32+24) +: 8] = a[0][i][7:0];
		assign y[((COL-1-i)*32+16) +: 8] = a[1][i][7:0];
		assign y[((COL-1-i)*32+8) +: 8] = a[2][i][7:0];
		assign y[((COL-1-i)*32) +: 8] = a[3][i][7:0];	
	end
	
endmodule
