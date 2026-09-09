
class driver extends uvm_driver #(transaction);

    `uvm_component_utils(driver)

    virtual intf vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual intf)::get(this, "", "vif", vif))
            `uvm_fatal("Error", "virtual intf not found")
    endfunction

    task run_phase(uvm_phase phase);
        transaction txn;
        vif.driver_cb.rst  <= 1;
        vif.driver_cb.vld  <= 0;
        vif.driver_cb.addr <= 0;
        vif.driver_cb.data <= 0;
        repeat(2) 
        @(vif.driver_cb);
        vif.driver_cb.rst <= 0;
        forever 
           begin
            seq_item_port.get_next_item(txn);
            @(vif.driver_cb);
            vif.driver_cb.rst  <= txn.rst;
            vif.driver_cb.vld  <= txn.vld;
            vif.driver_cb.addr <= txn.addr;
            vif.driver_cb.data <= txn.data;
            @(vif.driver_cb);
            seq_item_port.item_done();
        end
    endtask

endclass


