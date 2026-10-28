/////////////////////////////////////////////
// keyexpansion
//   Even funkier action on columns
//   Section 5.2
//   Routine applied to the key to generate 4 * (Nr+1) words
/////////////////////////////////////////////

module keyexpansion(input  logic clk,
					input logic [3:0] round,
					input logic [127:0] key, // array of Nk words that comprise the key
                    output logic [127:0] key_new);

	// note to self: Nk = 4
	
	logic [31:0] round_const;
	logic [7:0] output0, output1, output2, output3; // words
	logic [31:0] output_total, array0, array1, array2, array3, col0, col1, col2, col3;
	
	always_comb begin
		case(round)
			4'd1: round_const = 32'h01000000;
			4'd2: round_const = 32'h02000000;
			4'd3: round_const = 32'h04000000;
			4'd4: round_const = 32'h08000000;
			4'd5: round_const = 32'h10000000;
			4'd6: round_const = 32'h20000000;
			4'd7: round_const = 32'h40000000;
			4'd8: round_const = 32'h80000000;
			4'd9: round_const = 32'h1b000000;
			4'd10: round_const = 32'h36000000;
			default: round_const = 32'h01000000;
		endcase
	end
	
	// each word (which is selected by key) is one column from the state
	assign col0 = key[127:96];
	assign col1 = key[95:64];
	assign col2 = key[63:32];
	assign col3 = key[31:0];
	
	
	// subword() from sbox_sync for word (which is 32 bits total aka 4 bytes)
	sbox_sync sbox_sync_inst1 (.a(key[23:16]), .clk(clk), .y(output1));
	sbox_sync sbox_sync_inst2 (.a(key[15:8]), .clk(clk), .y(output2));
	sbox_sync sbox_sync_inst3 (.a(key[7:0]), .clk(clk), .y(output3));
	sbox_sync sbox_sync_inst0 (.a(key[31:24]), .clk(clk), .y(output0));
	
	// bringing each byte together into 1 word
	assign output_total = {output1, output2, output3, output0};
	
	// logic for key expansion
	assign array0 = col0 ^ output_total ^ round_const;
	assign array1 = col1 ^ array0;
	assign array2 = col2 ^ array1;
	assign array3 = col3 ^ array2;
	
	// putting the arrays together
	assign key_new = {array0, array1, array2, array3};
	
endmodule