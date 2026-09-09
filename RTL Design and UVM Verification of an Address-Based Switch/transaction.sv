

class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)
    rand bit  rst;
    rand bit  vld;
    rand bit [7:0]  addr;
    rand bit [15:0] data;

    bit [7:0]  addr_a;
    bit [15:0] data_a;
    bit [7:0]  addr_b;
    bit [15:0] data_b;

    constraint addr_c { addr inside {[0:255]};}
    constraint rst_c { rst inside {0,1}; }
    constraint vld_c { vld inside {0,1}; }


    function new(string name = "transaction");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("rst",rst , 1,UVM_DEC);
        printer.print_field("vld" ,vld ,1,UVM_DEC);
        printer.print_field("addr",addr ,8, UVM_DEC);
        printer.print_field("data",data ,16,UVM_HEX);
        printer.print_field("addr_a",addr_a,8, UVM_DEC);
        printer.print_field("data_a",data_a,16,UVM_HEX);
        printer.print_field("addr_b",addr_b,8,UVM_DEC);
        printer.print_field("data_b",data_b,16,UVM_HEX);
    endfunction

endclass

