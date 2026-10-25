/////////////////////////////////////////////
// keyexpansion
//   Even funkier action on columns
//   Section 5.2
//   Routine applied to the key to generate 4 * (Nr+1) words
/////////////////////////////////////////////
// TODOOOOOOOOO
module keyexpansion#(parameter Nr = 10)
				(input  logic clk,
					input logic [127:0] key, // array of Nk words that comprise the key
                  output logic [4*(Nr+1):0] w);

	genvar i;
	//roundkey needed?
	localparam Nk = 4 // number of 32-bit words comprising the key
	
	logic [31:0] round_const;
	
	always_comb begin
		case(round_num)
			4'd0: round_const = 8'h01000000;
			4'd1: round_const = 8'h02000000;
			4'd2: round_const = 8'h04000000;
			4'd3: round_const = 8'h08000000;
			4'd4: round_const = 8'h10000000;
			4'd5: round_const = 8'h20000000;
			4'd6: round_const = 8'h40000000;
			4'd7: round_const = 8'h80000000;
			4'd8: round_const = 8'h1b000000;
			4'd9: round_const = 8'h36000000;
			default: round_const = 8'h01000000;
		endcase
	end
	
	// rotword() and subword() from sbox_sync
	sbox_sync sbox_sync_inst0 (.a(key[127:96], .clk(clk), .y(output0));
	sbox_sync sbox_sync_inst1 (.a(key[95:64], .clk(clk), .y(output1));
	sbox_sync sbox_sync_inst2 (.a(key[63:32], .clk(clk), .y(output2));
	sbox_sync sbox_sync_inst3 (.a(key[31:0], .clk(clk), .y(output3));
	
	
	for (i=0; i<Nk-1; i++) begin
				assign w[i] = key[4*i];
		assign w[i] += key[4*i+1];
		assign w[i] += key[4*i+2];
		assign w[i] += key[4*i+3];

	end
	
	genvar j;
	
	for (j=0; j=<4*Nr+3; j++) begin
		temp = w[i-1];
		if (j % Nk == 0) begin // rotate word stuff
			temp = sbox(RotWord(temp)) ^ Rcon(i / Nk); // Line 10 ugh idk
		end
		else if ((Nk > 6) && (i % Nk == 4)) begin
			temp = Sbox_sync againnn // TODO
		end
		
		w[i] = w[i-Nk] ^ temp;
		
	end
	
	return w;
  
endmodule