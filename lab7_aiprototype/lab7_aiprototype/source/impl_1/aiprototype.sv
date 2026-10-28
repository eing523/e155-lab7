module word_array_expansion #(
    parameter int Nk    = 4,
    parameter int Nr    = 10,
    parameter int WIDTH = 32
)(
    input  logic [7:0]        key [0 : 4*Nk - 1],
    input  logic [WIDTH-1:0]  Rcon [0 : (4*Nr + 3) / Nk],
    output logic [WIDTH-1:0]  w [0 : 4*Nr + 3]
);

    genvar i;
    generate
        // First loop: Initialize initial words w[0] to w[Nk-1] from key
        for (i = 0; i < Nk; i = i + 1) begin : g_key_init
            assign w[i] = {key[4*i], key[4*i+1], key[4*i+2], key[4*i+3]};
        end

        // Second loop: Calculate w[Nk] through w[4*Nr + 3] using previous outputs
        for (i = Nk; i <= 4*Nr + 3; i = i + 1) begin : g_key_expand
            logic [WIDTH-1:0] temp_out;

            if (i % Nk == 0) begin : g_mod2_mod1
                logic [WIDTH-1:0] mod2_out;
                logic [WIDTH-1:0] mod1_out;

                // temp <- module1(module2(temp)) (+) Rcon[i/Nk]
                module2 u_module2 (
                    .in  (w[i-1]),
                    .out (mod2_out)
                );

                module1 u_module1 (
                    .in  (mod2_out),
                    .out (mod1_out)
                );

                assign temp_out = mod1_out ^ Rcon[i / Nk];

            end else if ((Nk > 6) && (i % Nk == 4)) begin : g_mod1_only
                logic [WIDTH-1:0] mod1_out;

                // temp <- module1(temp)
                module1 u_module1 (
                    .in  (w[i-1]),
                    .out (mod1_out)
                );

                assign temp_out = mod1_out;

            end else begin : g_bypass
                // Default path: temp <- w[i-1]
                assign temp_out = w[i-1];
            end

            // w[i] <- w[i-Nk] (+) temp
            assign w[i] = w[i-Nk] ^ temp_out;
        end
    endgenerate

endmodule
// SystemVerilog module for AES-128 Single-Round Combinational Key Expansion
/*module key_expansion_round (
    input  logic [127:0] prev_key,    // Round key from previous round (or initial key)
    input  logic [3:0]   round_num,   // Round index (1 to 10)
    output logic [127:0] next_key     // Computed round key for current round
);

    // Unpack previous round key into four 32-bit words (w[i-4] to w[i-1])
    logic [31:0] w0, w1, w2, w3;
    // Unpack next round key into four 32-bit words (w[i] to w[i+3])
    logic [31:0] w4, w5, w6, w7;

    logic [31:0] w3_rot;
    logic [31:0] w3_sub;
    logic [31:0] rcon;

    assign w0 = prev_key[127:96];
    assign w1 = prev_key[95:64];
    assign w2 = prev_key[63:32];
    assign w3 = prev_key[31:0];

    // Module instantiations for RotWord and SubWord
    RotWord rot_inst (
        .in (w3),
        .out(w3_rot)
    );

    SubWord sub_inst (
        .in (w3_rot),
        .out(w3_sub)
    );

    // Round Constant Lookup (Table 5 in FIPS-197)
    always_comb begin
        case (round_num)
            4'd1:  rcon = 32'h01_00_00_00;
            4'd2:  rcon = 32'h02_00_00_00;
            4'd3:  rcon = 32'h04_00_00_00;
            4'd4:  rcon = 32'h08_00_00_00;
            4'd5:  rcon = 32'h10_00_00_00;
            4'd6:  rcon = 32'h20_00_00_00;
            4'd7:  rcon = 32'h40_00_00_00;
            4'd8:  rcon = 32'h80_00_00_00;
            4'd9:  rcon = 32'h1B_00_00_00;
            4'd10: rcon = 32'h36_00_00_00;
            default: rcon = 32'h00_00_00_00;
        endcase
    end

    // Recursive word generation logic (Section 5.2)
    assign w4 = w0 ^ w3_sub ^ rcon;
    assign w5 = w1 ^ w4;
    assign w6 = w2 ^ w5;
    assign w7 = w3 ^ w6;

    // Pack output words back into 128-bit key
    assign next_key = {w4, w5, w6, w7};

endmodule */