
class agent extends uvm_agent;

    `uvm_component_utils(agent)

    sequencer seqrh;
    driver drvh;
    monitor monh;

    uvm_analysis_port #(transaction) anp;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        anp = new("anp", this);
        seqrh = sequencer::type_id::create("seqrh", this);
        drvh =driver::type_id::create("drvh", this);
        monh =monitor::type_id::create("monh", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drvh.seq_item_port.connect(seqrh.seq_item_export);
        monh.anp.connect(anp);
    endfunction

endclass

