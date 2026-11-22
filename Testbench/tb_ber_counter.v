
`timescale 1ns/1ps

module tb_ber_counter;

reg clk;
reg reset;
reg tx_bit;
reg rx_bit;

wire [15:0] error_count;
wire [15:0] total_count;

ber_counter uut(
    .clk(clk),
    .reset(reset),
    .tx_bit(tx_bit),
    .rx_bit(rx_bit),
    .error_count(error_count),
    .total_count(total_count)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("ber_counter.vcd");
    $dumpvars(0, tb_ber_counter);

    $monitor("Time=%0t TX=%b RX=%b Total=%d Errors=%d",
             $time, tx_bit, rx_bit, total_count, error_count);

    clk = 0;
    reset = 1;
    tx_bit = 0;
    rx_bit = 0;

    #12;
    reset = 0;

    tx_bit = 1;
    rx_bit = 1;
    #10;

    tx_bit = 0;
    rx_bit = 0;
    #10;

    tx_bit = 1;
    rx_bit = 0;
    #10;

    tx_bit = 0;
    rx_bit = 1;
    #10;

    tx_bit = 1;
    rx_bit = 1;
    #10;

    $display("Final Total Bits = %d", total_count);
    $display("Final Error Count = %d", error_count);

    $finish;
end

endmodule