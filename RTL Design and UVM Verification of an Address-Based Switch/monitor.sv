

class monitor extends uvm_monitor;

    `uvm_component_utils(monitor)

    virtual intf vif;
    uvm_analysis_port #(transaction) anp;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        anp = new("anp", this);
        if (!uvm_config_db #(virtual intf)::get(this, "", "vif", vif))
            `uvm_fatal("Error", "virtual intf not found")
    endfunction

    task run_phase(uvm_phase phase);
       transaction txn;
        forever 
            begin
            @(vif.monitor_cb);
            txn =transaction::type_id::create("txn");
            txn.rst = vif.monitor_cb.rst;
            txn.vld = vif.monitor_cb.vld;
            txn.addr = vif.monitor_cb.addr;
            txn.data = vif.monitor_cb.data;
            txn.addr_a = vif.monitor_cb.addr_a;
            txn.data_a = vif.monitor_cb.data_a;
            txn.addr_b = vif.monitor_cb.addr_b;
            txn.data_b = vif.monitor_cb.data_b;
            anp.write(txn);
        end
    endtask

endclass

