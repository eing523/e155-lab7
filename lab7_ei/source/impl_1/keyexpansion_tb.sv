`timescale 10ns/1ns
/////////////////////////////////////////////
// keyexpansion testbench
// Demonstrates creating 4 words (a key)
/////////////////////////////////////////////

module keyexpansion_tb();
    logic clk;
	logic [3:0] round;
	logic [127:0] key; // array of Nk words that comprise the key
    logic [127:0] key_new;
	
	logic [127:0] key_new_expected;
    
    // device under test
    keyexpansion dut(.clk(clk), .round(round), .key(key), .key_new(key_new));
    
	
	// generate clock and load signals
    always begin
      clk = 1'b0; #5;
      clk = 1'b1; #5;
    end
	
    initial begin
		
		round = 1;
		// do this because we using old key to get key_new
		key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		key_new_expected = 128'ha0fafe1788542cb123a339392a6c7605;
		
		# 50;
		
		assert (key_new == key_new_expected)
			$display("Passed! (Appendix B)");
		else
			$error("Failed! (Appendix B)");

    end
    
    
  
    
endmodule