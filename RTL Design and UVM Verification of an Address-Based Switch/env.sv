

class env extends uvm_env;

    `uvm_component_utils(env)

    agent agnth;
    scoreboard sbh;
    config cfg;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        cfg =config::type_id::create("cfg");

        if (!uvm_config_db #(virtual intf)::get(this, "", "vif", cfg.vif))
            `uvm_fatal("error", "virtual intf not found")

        uvm_config_db #(virtual intf)::set(this, "agnth.*", "vif", cfg.vif);

       agnth =agent::type_id::create("agnth", this);
      sbh=scoreboard::type_id::create("sbh", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        agnth.anp.connect(sbh.analysis_export);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

endclass

