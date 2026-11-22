
`timescale 1ns/1ps

module tb_bpsk_modulator;

reg bit_in;
wire signed [3:0] symbol_out;

bpsk_modulator uut(
    .bit_in(bit_in),
    .symbol_out(symbol_out)
);

initial begin
    $dumpfile("modulator.vcd");
    $dumpvars(0, tb_bpsk_modulator);
    $monitor("Time=%0t bit_in=%b symbol_out=%d",
             $time, bit_in, symbol_out);

    bit_in = 0;
    #10;

    bit_in = 1;
    #10;

    bit_in = 0;
    #10;

    bit_in = 1;
    #10;

    $finish;
end

endmodule