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

    
    // device under test
    keyexpansion dut(.clk(clk), .round(round), .key(key), .key_new(key_new));
    
	// generate clock and load signals
    always begin
      clk = 1'b0; #5;
      clk = 1'b1; #5;
    end
	
    initial begin
        tests = 0; errors = 0;

		
        // Test 2: FIPS-197 Appendix B, Round 1, "After MixColumns" -> "Round Key Value".
        check("Appendix B round 1", 128'h046681e5e0cb199a48f8d37a2806264c, 128'ha0fafe1788542cb123a339392a6c7605);

        // Test 3: FIPS-197 Appendix B, Round 2, "After MixColumns" -> "Round Key Value".
        check("Appendix B round 2", 128'h584dcaf11b4b5aacdbe7caa81b6bb0e5, 128'hf2c295f27a96b9435935807a7359f67f);

        if (errors == 0) $display("PASSED: all %0d tests", tests);
        else             $display("FAILED: %0d of %0d tests", errors, tests);
        $finish;
    end
    
    
  
    
endmodule