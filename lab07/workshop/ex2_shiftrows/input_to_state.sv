`timescale 10ns/1ns

/////////////////////////////////////////////
// input_to_state
//   Only needed if you want to use the state array inside shiftrows.
//   Paste the body of your input_to_state from Exercise 1 here.
//   If you work on the 128-bit vector directly, leave this file alone.
/////////////////////////////////////////////

module input_to_state(input  logic [127:0]         a,
                      output logic [0:3][0:3][7:0] y);

	
	localparam COL = 4; // total number of columns
	
	genvar i;
	
	// want to cycle through each column
	// bits start at 0 so we need to subtract 1 from COL.
	// +24 is the 1st row, +16 is the second, +8 is third, +0 is fourth row
	// we follow these conventions since MSB is fed in first
	for (i=0; i<COL; i++) begin
		assign y[0][i][7:0] = a[((COL-1-i)*32+24) +: 8];
		assign y[1][i][7:0] = a[((COL-1-i)*32+16) +: 8];
		assign y[2][i][7:0] = a[((COL-1-i)*32+8) +: 8];
		assign y[3][i][7:0] = a[((COL-1-i)*32) +: 8];	
	end
	
	
endmodule
