`timescale 1ns/1ps

`include "uvm_macros.svh"

import uvm_pkg::*;
import test_pkg::*;



module tb_top;

    parameter ADDR_WIDTH = 8;
    parameter DATA_WIDTH = 16;
    parameter ADDR_DIV   = 8'd100;

    logic clk;

    initial clk = 0;
    always #5 clk = ~clk;

    intf #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .ADDR_DIV(ADDR_DIV)) u_if(.clk(clk));

    switch dut (
        .clk    (clk),
        .rst    (u_if.rst),
        .vld    (u_if.vld),
        .addr   (u_if.addr),
        .data   (u_if.data),
        .addr_a (u_if.addr_a),
        .data_a (u_if.data_a),
        .addr_b (u_if.addr_b),
        .data_b (u_if.data_b)
    );

    property p_rst;
        @(posedge clk) (u_if.rst == 1) |=> (u_if.addr_a == 0 && u_if.addr_b == 0);
    endproperty

    property p_vld;
        @(posedge clk) (u_if.vld == 0) |=> (u_if.addr_a == 0 && u_if.addr_b == 0);
    endproperty

    property p_a;
        @(posedge clk) (u_if.vld == 1 && u_if.rst == 0 && u_if.addr <= ADDR_DIV)
                       |=> (u_if.addr_a == $past(u_if.addr));
    endproperty

    property p_b;
        @(posedge clk) (u_if.vld == 1 && u_if.rst == 0 && u_if.addr > ADDR_DIV)
                       |=> (u_if.addr_b == $past(u_if.addr));
    endproperty

    assert property (p_rst)   else `uvm_error("SVA", "FAIL: p_rst")
    assert property (p_vld) else `uvm_error("SVA", "FAIL: p_vld")
    assert property (p_a)      else `uvm_error("SVA", "FAIL: p_a")
    assert property (p_b)      else `uvm_error("SVA", "FAIL: p_b")

    initial begin
        uvm_config_db #(virtual intf)::set(null, "uvm_test_top.*", "vif", u_if);
        run_test("seq1_test");
    end

endmodule
