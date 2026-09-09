`timescale 1ns/1ps

module switch #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 16,
    parameter ADDR_DIV   = 8'd100)

(
    input clk,
    input rst,
    input vld,
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] data,
    output reg [ADDR_WIDTH-1:0] addr_a,
    output reg [DATA_WIDTH-1:0] data_a,
    output reg [ADDR_WIDTH-1:0] addr_b,
    output reg [DATA_WIDTH-1:0] data_b );

    always @(posedge clk) begin
        if ((vld==1&&rst==1)||(vld==0&&rst==1)||(vld==0&&rst==0)) begin
            addr_a <= 0; data_a <= 0;
            addr_b <= 0; data_b <= 0;
        end else if ((vld==1)&&(rst==0)) begin
            if (addr >= 0 && addr <= ADDR_DIV) begin
                addr_a <= addr; data_a <= data;
                addr_b <= 0;    data_b <= 0;
            end else begin
                addr_a <= 0;    data_a <= 0;
                addr_b <= addr; data_b <= data;
            end
        end
    end

endmodule
