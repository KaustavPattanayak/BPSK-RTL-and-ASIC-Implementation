
module ber_counter(
    input wire clk,
    input wire reset,
    input wire tx_bit,
    input wire rx_bit,
    output reg [15:0] error_count,
    output reg [15:0] total_count
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        error_count <= 16'd0;
        total_count <= 16'd0;
    end
    else begin
        total_count <= total_count + 16'd1;

        if (tx_bit != rx_bit)
            error_count <= error_count + 16'd1;
    end
end

endmodule