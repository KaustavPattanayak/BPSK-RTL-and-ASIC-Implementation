
module bpsk_demodulator(
    input wire signed [3:0] symbol_in,
    output reg bit_out
);

always @(*) begin
    if (symbol_in >= 0)
        bit_out = 1'b1;
    else
        bit_out = 1'b0;
end

endmodule