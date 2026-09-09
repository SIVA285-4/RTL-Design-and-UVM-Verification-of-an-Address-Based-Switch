`timescale 1ns / 1ps

module switch_tb;

    parameter ADDR_WIDTH = 8;
    parameter DATA_WIDTH = 16;
    parameter ADDR_DIV   = 8'd100;

    reg clk;
    reg rst;
    reg vld;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] data;

    wire [ADDR_WIDTH-1:0] addr_a;
    wire [DATA_WIDTH-1:0] data_a;
    wire [ADDR_WIDTH-1:0] addr_b;
    wire [DATA_WIDTH-1:0] data_b;


    // DUT
    switch #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_DIV(ADDR_DIV)
    ) dut (
        .clk(clk),
        .rst(rst),
        .vld(vld),
        .addr(addr),
        .data(data),
        .addr_a(addr_a),
        .data_a(data_a),
        .addr_b(addr_b),
        .data_b(data_b)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task stimulus(
        input rst_in,
        input vld_in,
        input [ADDR_WIDTH-1:0] addr_in,
        input [DATA_WIDTH-1:0] data_in
    );
    begin
        @(negedge clk);

        rst  = rst_in;
        vld  = vld_in;
        addr = addr_in;
        data = data_in;
    end
    endtask

    initial begin

        rst  = 0;
        vld  = 0;
        addr = 0;
        data = 0;

        stimulus(1, 0, 8'd0, 16'h0000);

        stimulus(0, 0, 8'd0, 16'h0000);

        stimulus(0, 1, 8'd10, 16'hAAAA);

        stimulus(0, 1, 8'd50, 16'hBBBB);

        stimulus(0, 1, 8'd100, 16'hCCCC);

        stimulus(0, 1, 8'd101, 16'hDDDD);

        stimulus(0, 1, 8'd150, 16'hEEEE);

        stimulus(0, 1, 8'd200, 16'hFFFF);

        stimulus(0, 0, 8'd50, 16'h1234);

        stimulus(1, 0, 8'd0, 16'h0000);


        #20;
        $finish;

    end


endmodule