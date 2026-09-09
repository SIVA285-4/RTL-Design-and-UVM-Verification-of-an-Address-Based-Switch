
class scoreboard extends uvm_scoreboard;

    `uvm_component_utils(scoreboard)

    uvm_analysis_imp #(transaction,scoreboard) analysis_export;

    int pass_cnt;
    int fail_cnt;

    transaction m_txn;
    transaction prev_txn;
    bit first_txn;

    covergroup cg;
        cp_rst:coverpoint m_txn.rst { bins rst_0 = {0}; bins rst_1 = {1}; }
        cp_vld:coverpoint m_txn.vld { bins vld_0 = {0}; bins vld_1 = {1}; }
        cp_addr:coverpoint m_txn.addr{
            bins addr_0 = {0};
            bins addr_l  = {[1:99]};
            bins addr_d  = {100};
            bins addr_h = {[101:254]};
            bins addr_m = {255};
        }
        cp_data: coverpoint m_txn.data {
            bins data_0 = {0};
            bins data_l  = {[1:16'hFFFE]};
            bins data_h  = {16'hFFFF};
        }
        vld_addr: cross cp_vld, cp_addr;
        rst_vld: cross cp_rst, cp_vld;
    endgroup

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg  = new();
        //first_txn = 1;
       // prev_txn = transaction::type_id::create("prev_txn");
        pass_cnt = 0;
        fail_cnt = 0;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        analysis_export = new("analysis_export", this);
    endfunction

/*   function void write(transaction txn);
        bit [7:0] exp_addr_a;
        bit [15:0] exp_data_a;
        bit [7:0] exp_addr_b;
        bit [15:0] exp_data_b;

        m_txn = txn;
        cg.sample();

        reference_model(txn, exp_addr_a, exp_data_a, exp_addr_b, exp_data_b);

        if (txn.addr_a === exp_addr_a && txn.data_a === exp_data_a && txn.addr_b === exp_addr_b && txn.data_b === exp_data_b)
            begin
            `uvm_info("SCOREBOARD", $sformatf("PASS"))
            pass_cnt++;
        end 
       else 
        begin
            `uvm_error("SCOREBOARD", $sformatf("FAIL"))
            fail_cnt++;
        end
    endfunction */
function void write(transaction txn);

    bit [7:0] exp_addr_a;
    bit [15:0] exp_data_a;
    bit [7:0] exp_addr_b;
    bit [15:0] exp_data_b;

    m_txn = txn;
    cg.sample();

    if(first_txn)
    begin
        prev_txn = txn;
        first_txn = 0;
        return;
    end

    reference_model(prev_txn,
                    exp_addr_a,
                    exp_data_a,
                    exp_addr_b,
                    exp_data_b);

    if(txn.addr_a === exp_addr_a &&
       txn.data_a === exp_data_a &&
       txn.addr_b === exp_addr_b &&
       txn.data_b === exp_data_b)
    begin
        `uvm_info("SCOREBOARD","PASS",UVM_NONE)
        pass_cnt++;
    end
    else
    begin
        `uvm_error("SCOREBOARD",
            $sformatf("FAIL exp_a=%0d exp_da=%0d exp_b=%0d exp_db=%0d act_a=%0d act_da=%0d act_b=%0d act_db=%0d",
            exp_addr_a,exp_data_a,exp_addr_b,exp_data_b,
            txn.addr_a,txn.data_a,txn.addr_b,txn.data_b))
        fail_cnt++;
    end

    prev_txn = txn;

endfunction
    function void reference_model(
        transaction txn,
        output bit [7:0] exp_addr_a,
        output bit [15:0] exp_data_a,
        output bit [7:0] exp_addr_b,
        output bit [15:0] exp_data_b
    );
        if (txn.rst == 1 || txn.vld == 0) 
        begin
            exp_addr_a = 0; exp_data_a = 0;
            exp_addr_b = 0; exp_data_b = 0;
        end  
            else if (txn.addr <= 100) 
        begin
            exp_addr_a = txn.addr; exp_data_a = txn.data;
            exp_addr_b = 0;        exp_data_b = 0;
        end 
        else 
        begin
            exp_addr_a = 0;        exp_data_a = 0;
            exp_addr_b = txn.addr; exp_data_b = txn.data;
        end
    endfunction

    function void report_phase(uvm_phase phase);
        `uvm_info("SCOREBOARD", $sformatf("PASS = %0d  FAIL = %0d", pass_cnt, fail_cnt),UVM_NONE)
        `uvm_info("SCOREBOARD", $sformatf("Functional Coverage = %.2f%%",cg.get_coverage()), UVM_NONE)
    endfunction

endclass
