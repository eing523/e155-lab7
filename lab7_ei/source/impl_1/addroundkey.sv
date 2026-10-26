/////////////////////////////////////////////
// addroundkey
//   transformation of the state (the 4x4 array s),
// in which a round key is combined with the state using XOR
//   Section 5.1.4, Figure 5
/////////////////////////////////////////////

module addroundkey(input  logic [127:0] state,
				   input  logic [127:0] round_key,
				   output logic [127:0] y_output);
   
    assign y_output = state ^ round_key;
	
	
endmodule
