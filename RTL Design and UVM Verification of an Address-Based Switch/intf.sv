interface intf #(parameter ADDR_WIDTH = 8, parameter DATA_WIDTH = 16, parameter ADDR_DIV = 8'd100) (input logic clk);

    logic                   rst;
    logic                   vld;
    logic [ADDR_WIDTH-1:0]  addr;
    logic [DATA_WIDTH-1:0]  data;
    logic [ADDR_WIDTH-1:0]  addr_a;
    logic [DATA_WIDTH-1:0]  data_a;
    logic [ADDR_WIDTH-1:0]  addr_b;
    logic [DATA_WIDTH-1:0]  data_b;

    clocking driver_cb @(posedge clk);
        default input #1 output #1;
        output rst;
        output vld;
        output addr;
        output data;
        input  addr_a;
        input  data_a;
        input  addr_b;
        input  data_b;
    endclocking

    clocking monitor_cb @(posedge clk);
        default input #1 output #1;
        input rst;
        input vld;
        input addr;
        input data;
        input addr_a;
        input data_a;
        input addr_b;
        input data_b;
    endclocking

    modport driver_mp  (clocking driver_cb);
    modport monitor_mp (clocking monitor_cb);

endinterface
