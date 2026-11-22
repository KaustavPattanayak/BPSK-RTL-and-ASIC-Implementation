
`timescale 1ns/1ps

module tb_bpsk_demodulator;

reg signed [3:0] symbol_in;
wire bit_out;

bpsk_demodulator uut(
    .symbol_in(symbol_in),
    .bit_out(bit_out)
);

initial begin
    $dumpfile("demodulator.vcd");
    $dumpvars(0, tb_bpsk_demodulator);

    $monitor("Time=%0t symbol_in=%d bit_out=%b",
             $time, symbol_in, bit_out);

    symbol_in = 1;
    #10;

    symbol_in = -1;
    #10;

    symbol_in = 1;
    #10;

    symbol_in = -1;
    #10;

    $finish;
end

endmodule