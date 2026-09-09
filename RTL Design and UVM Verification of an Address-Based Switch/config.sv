

class config extends uvm_object;

    `uvm_object_utils(config)

    virtual intf vif;

    function new(string name = "config");
        super.new(name);
    endfunction

endclass


