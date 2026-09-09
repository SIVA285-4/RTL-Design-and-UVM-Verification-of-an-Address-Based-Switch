

class base_seq extends uvm_sequence #(transaction);
    `uvm_object_utils(base_seq)
    function new(string name = "base_seq");
        super.new(name);
    endfunction
endclass

class seq1 extends base_seq;
    `uvm_object_utils(seq1)
    function new(string name = "seq1");
        super.new(name);
    endfunction
    task body();
        transaction txn;
        repeat(20) 
           begin
            txn =transaction::type_id::create("txn");
            start_item(txn);
            assert(txn.randomize() with { rst == 0; vld == 1; });
            finish_item(txn);
        end
    endtask
endclass

class seq2 extends base_seq;
    `uvm_object_utils(seq2)
    function new(string name = "seq2");
        super.new(name);
    endfunction
    task body();
        transaction txn;
        repeat(10)
             begin
            txn = transaction::type_id::create("txn");
            start_item(txn);
            assert(txn.randomize() with { rst == 1; vld == 1; });
            finish_item(txn);
        end
        repeat(10) begin
            txn =transaction::type_id::create("txn");
            start_item(txn);
            assert(txn.randomize() with { rst == 0; vld == 0; });
            finish_item(txn);
        end
    endtask
endclass

class seq3 extends base_seq;
    `uvm_object_utils(seq3)
    function new(string name = "seq3");
        super.new(name);
    endfunction
    task body();
        transaction txn;
        txn = transaction::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize() with { rst == 0; vld == 1; addr == 100; data == 16'hFFFF; });
        finish_item(txn);
    endtask
endclass


