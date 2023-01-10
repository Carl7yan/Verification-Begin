class agent extends uvm_agent;
  `uvm_component_utils(agent)
  function new(string name = "agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  driver d0;
  monitor m0;
  uvm_sequencer #(Item) s0;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    s0 = uvm_sequencer#(Item)::type_id::create("s0", this);
    d0 = driver::type_id::create("d0", this);
    m0 = monitor::type_id::create("m0", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d0.seq_item_port.connect(s0.seq_item_export);
  endfunction
endclass


class env extends uvm_env;
  `uvm_component_utils(env)
  function new(string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  agent a0;
  scoreboard sb0;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a0 = agent::type_id::create("a0", this);
    sb0 = scoreboard::type_id::create("sb0", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    a0.m0.mon_analysis_port.connect(sb0.m_analysis_imp);
  endfunction
endclass
