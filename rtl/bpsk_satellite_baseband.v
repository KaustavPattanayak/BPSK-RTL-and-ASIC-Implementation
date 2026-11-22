
module bpsk_satellite_baseband(
    input wire clk,
    input wire reset,
    input wire tx_bit,
    input wire signed [3:0] received_symbol,
    output wire signed [3:0] tx_symbol,
    output wire rx_bit,
    output wire [15:0] error_count,
    output wire [15:0] total_count
);

bpsk_modulator modulator(
    .bit_in(tx_bit),
    .symbol_out(tx_symbol)
);

bpsk_demodulator demodulator(
    .symbol_in(received_symbol),
    .bit_out(rx_bit)
);

ber_counter counter(
    .clk(clk),
    .reset(reset),
    .tx_bit(tx_bit),
    .rx_bit(rx_bit),
    .error_count(error_count),
    .total_count(total_count)
);

endmodule