`timescale 10ns/1ns
/////////////////////////////////////////////
// keyexpansion testbench
// Demonstrates creating 4 words (a key)
/////////////////////////////////////////////

module addroundkey_tb();
    logic [127:0] state;
	logic [127:0] round_key;
	logic [127:0] y_output;
	
	logic [127:0] y_output_expected;
    
    // device under test
    addroundkey dut(.state(state), .round_key(round_key), .y_output(y_output));
    
	
	
    initial begin
		// going from mixcols to addroundkey
		state = 128'h193de3bea0f4e22b9ac68d2ae9f84808;
		round_key = 128'ha0fafe1788542cb123a339392a6c7605;
		y_output_expected = 128'hb9c71da928a0ce9ab965b413c3943e0d; // xor'd result
		
		# 50;
		
		assert (y_output == y_output_expected)
			$display("Passed! (Appendix B)");
		else
			$error("Failed! (Appendix B)");
       
    end
    
    
  
    
endmodule