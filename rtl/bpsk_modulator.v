
module bpsk_modulator(
    input wire bit_in,
    output reg signed [3:0] symbol_out
);

always @(*) begin
    if (bit_in == 1'b0)
        symbol_out = -4'sd1;
    else
        symbol_out = 4'sd1;
end

endmodule