
class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    env envh;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        envh=env::type_id::create("envh", this);
    endfunction

endclass

class seq1_test extends base_test;

    `uvm_component_utils(seq1_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        seq1 seq;
        phase.raise_objection(this);
        seq =seq1::type_id::create("seq");
        seq.start(envh.agnth.seqrh);
        phase.drop_objection(this);
    endtask

endclass

class seq2_test extends base_test;

    `uvm_component_utils(seq2_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        seq2 seq;
        phase.raise_objection(this);
        seq =seq2::type_id::create("seq");
        seq.start(envh.agnth.seqrh);
        phase.drop_objection(this);
    endtask

endclass

class seq3_test extends base_test;

    `uvm_component_utils(seq3_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        seq3 seq;
        phase.raise_objection(this);
        seq =seq3::type_id::create("seq");
        seq.start(envh.agnth.seqrh);
        phase.drop_objection(this);
    endtask

endclass

