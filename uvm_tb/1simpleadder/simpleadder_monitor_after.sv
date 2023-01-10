class simpleadder_monitor_after extends uvm_monitor;
  `uvm_component_utils(simpleadder_monitor_after)
  uvm_analysis_port#(simpleadder_transaction) mon_ap_after;

  virtual simpleadder_if vif;
  simpleadder_transaction sa_tx_cg;

  covergroup simpleadder_cg;
    ina_cp:   coverpoint sa_tx_cg.ina;
    inb_cp:   coverpoint sa_tx_cg.inb;
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    simpleadder_cg = new;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    void'(uvm_resource_db#(virtual simpleadder_if)::read_by_name(.scope("ifs"), .name("simpleadder_if"), .val(vif)));
    mon_ap_after= new(.name("mon_ap_after"), .parent(this));
   endfunction: build_phase

   task run_phase(uvm_phase phase);
          //Our code here
   endtask: run_phase
endclass
