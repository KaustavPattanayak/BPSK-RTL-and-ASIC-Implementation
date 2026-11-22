

`timescale 1ns/1ps

module tb_bpsk_satellite_baseband;

reg clk;
reg reset;
reg tx_bit;
reg signed [3:0] received_symbol;

wire signed [3:0] tx_symbol;
wire rx_bit;
wire [15:0] error_count;
wire [15:0] total_count;

bpsk_satellite_baseband dut (
    .clk(clk),
    .reset(reset),
    .tx_bit(tx_bit),
    .received_symbol(received_symbol),
    .tx_symbol(tx_symbol),
    .rx_bit(rx_bit),
    .error_count(error_count),
    .total_count(total_count)
);

always #5 clk = ~clk;

task send_sample;
    input tx;
    input signed [3:0] rx;
    begin
        @(negedge clk);
        tx_bit = tx;
        received_symbol = rx;
        @(posedge clk);
        #1;
    end
endtask

initial begin
    $dumpfile("bpsk_satellite_baseband.vcd");
    $dumpvars(0, tb_bpsk_satellite_baseband);
    clk = 0;
    reset = 1;
    tx_bit = 0;
    received_symbol = -1;

    #12;
    reset = 0;

    // TEST 1: Five correct bits
    send_sample(0, -1);
    send_sample(1,  1);
    send_sample(0, -1);
    send_sample(1,  1);
    send_sample(1,  1);

    $display("TEST 1: Total=%0d Errors=%0d",
             total_count, error_count);

    // TEST 2: Reset, then introduce one error
    @(negedge clk);
    reset = 1;
    @(negedge clk);
    reset = 0;

    send_sample(0, -1);
    send_sample(1,  1);
    send_sample(0,  1);
    send_sample(1,  1);
    send_sample(0, -1);

    $display("TEST 2: Total=%0d Errors=%0d",
             total_count, error_count);

    // TEST 3: Check reset clears the counters
    @(negedge clk);
    reset = 1;
    @(negedge clk);
    reset = 0;

    send_sample(1, 1);
    send_sample(0, 1);

    $display("TEST 3A before reset: Total=%0d Errors=%0d",
             total_count, error_count);

    @(negedge clk);
    reset = 1;
    #1;
    $display("TEST 3B during reset: Total=%0d Errors=%0d",
             total_count, error_count);

    @(negedge clk);
    reset = 0;

    send_sample(0, -1);

    $display("TEST 3C after reset: Total=%0d Errors=%0d",
             total_count, error_count);

    $finish;
end

endmodule
