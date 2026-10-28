/////////////////////////////////////////////
// aes_core
//   top level AES encryption module
//   when load is asserted, takes the current key and plaintext
//   generates cyphertext and asserts done when complete 11 cycles later
// 
//   See FIPS-197 with Nk = 4, Nb = 4, Nr = 10
//
//   The key and message are 128-bit values packed into an array of 16 bytes as
//   shown below
//        [127:120] [95:88] [63:56] [31:24]     S0,0    S0,1    S0,2    S0,3
//        [119:112] [87:80] [55:48] [23:16]     S1,0    S1,1    S1,2    S1,3
//        [111:104] [79:72] [47:40] [15:8]      S2,0    S2,1    S2,2    S2,3
//        [103:96]  [71:64] [39:32] [7:0]       S3,0    S3,1    S3,2    S3,3
//
//   Equivalently, the values are packed into four words as given
//        [127:96]  [95:64] [63:32] [31:0]      w[0]    w[1]    w[2]    w[3]
/////////////////////////////////////////////

module aes_core(input  logic         clk, 
                input  logic         load,
                input  logic [127:0] key, 
                input  logic [127:0] plaintext, 
                output logic         done, 
                output logic [127:0] cyphertext);
	
	
	// note to self: Nr = 10 
	
	typedef enum logic [1:0] {IDLE, DELAY, ROUNDS, END} statetype;
	statetype state, nextstate;
	
	logic [3:0] round, prev_round;
	// maybe no need: next_load
	logic [127:0] fsm_next_result, fsm_result, key_new; // key_new is the round key
	logic [127:0] prev_key;
	logic [127:0] subbytes_out, shiftrows_out, mixcols_out, addrndkey_out, addrndkey_out_final, keyexpans_out;

	
	subbytes subbytes_inst(.a(fsm_result), .clk(clk), .y(subbytes_out));
	shiftrows shiftrows_inst(.a(subbytes_out), .y(shiftrows_out));
	mixcolumns mixcolumns_inst(.a(shiftrows_out), .y(mixcols_out));
	addroundkey addroundkey_inst(.state(mixcols_out), .round_key(key_new), .y_output(addrndkey_out));
	addroundkey addroundkey_inst_final(.state(shiftrows_out), .round_key(key_new), .y_output(addrndkey_out_final)); // for the last round that doesn't include mixcols

	
	keyexpansion keyexpansion_inst(.clk(clk), .round(round), .key(prev_key), .key_new(key_new));
	
	
	// state register
	always_ff @(posedge clk) begin
		if (load) begin
			state <= IDLE;
			round <= 4'd0;
			fsm_result <= plaintext;
			prev_key <= key;
		end
		
		else begin 
			state <= nextstate;
			fsm_result <= fsm_next_result;
			round <= prev_round;
			if (state == ROUNDS) begin prev_key <= key_new; end
			
		end
	end
	
	// next state logic
	always_comb begin
		nextstate = state;
		fsm_next_result = fsm_result;
		prev_round = round;
		done = 0;
		
		case(state)
			IDLE: begin
				if (!load) begin
					fsm_next_result = plaintext ^ key;
					prev_round = 4'd1;
					nextstate = DELAY;
				end
				else begin
					nextstate = IDLE;
				end	
			end
			
			DELAY: begin nextstate = ROUNDS; end // this is needed so subbytes can provide an output, since it answers a tick late
			
			ROUNDS: begin
				prev_round = round + 4'd1;
				if (round == 4'd10) begin
					fsm_next_result = addrndkey_out_final;
					nextstate = END;
				end else begin
					
					fsm_next_result = addrndkey_out;
					nextstate = DELAY;
					
				end
			
			end
					
			END: begin
				done = 1;
				nextstate = END; 
			end
			
			default: nextstate = IDLE;
		
		endcase
	end
	
	assign cyphertext = fsm_result;
			
	
    
endmodule