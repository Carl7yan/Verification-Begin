//-------------------------------------------------------------------------
//		dma_reg_test - www.verificationguide.com 
//-------------------------------------------------------------------------
`include "dma_env.sv"

class dma_reg_test extends uvm_test;

  `uvm_component_utils(dma_reg_test)
  
  //---------------------------------------
  // env instance 
  //--------------------------------------- 
  dma_model_env env;
  
  //---------------------------------------
  // sequence instance 
  //--------------------------------------- 
  write_sequence wr_seq;
  read_sequence  rd_seq;

  //---------------------------------------
  // constructor
  //---------------------------------------
  function new(string name = "dma_reg_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the env
    env = dma_model_env::type_id::create("env", this);
    
    // Create the sequence
    wr_seq = write_sequence::type_id::create("wr_seq");
    rd_seq = read_sequence::type_id::create("rd_seq");
  endfunction : build_phase

  //---------------------------------------
  // end_of_elobaration phase
  //---------------------------------------  
  virtual function void end_of_elaboration();
    //print's the topology
    print();
  endfunction
  
  //---------------------------------------
  // run_phase - starting the test
  //---------------------------------------
  task run_phase(uvm_phase phase);    
    phase.raise_objection(this);
    
    wr_seq.t_addr = `INTR_SFR_ADDR;
    wr_seq.t_data = 32'hFFFF_0F0F;
    wr_seq.start(env.dma_agnt.sequencer);
    
    wr_seq.t_addr = `CTRL_SFR_ADDR;
    wr_seq.t_data = 32'h1234_5678;
    wr_seq.start(env.dma_agnt.sequencer);
    
    wr_seq.t_addr = `IO_ADDR_SFR_ADDR;
    wr_seq.t_data = 32'hABCD_EF12;
    wr_seq.start(env.dma_agnt.sequencer);
    
    wr_seq.t_addr = `MEM_ADDR_SFR_ADDR;
    wr_seq.t_data = 32'h9731_2345;
    wr_seq.start(env.dma_agnt.sequencer);

    rd_seq.t_addr = `INTR_SFR_ADDR;
    rd_seq.start(env.dma_agnt.sequencer);
    
    rd_seq.t_addr = `CTRL_SFR_ADDR;
    rd_seq.start(env.dma_agnt.sequencer);
    
    rd_seq.t_addr = `IO_ADDR_SFR_ADDR;
    rd_seq.start(env.dma_agnt.sequencer);
    
    rd_seq.t_addr = `MEM_ADDR_SFR_ADDR;
    rd_seq.start(env.dma_agnt.sequencer);    
    phase.drop_objection(this);
  endtask : run_phase
  
endclass : dma_reg_test




class dma_reg_test_random extends uvm_test;

  `uvm_component_utils(dma_reg_test_random)
  
  //---------------------------------------
  // env instance 
  //--------------------------------------- 
  dma_model_env env;
  
  //---------------------------------------
  // sequence instance 
  //--------------------------------------- 
  dma_sequence   dma_seq;

  //---------------------------------------
  // constructor
  //---------------------------------------
  function new(string name = "dma_reg_test_random",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the env
    env = dma_model_env::type_id::create("env", this);
    
    // Create the sequence
    dma_seq = dma_sequence::type_id::create("dma_seq");
  endfunction : build_phase

  //---------------------------------------
  // end_of_elobaration phase
  //---------------------------------------  
  virtual function void end_of_elaboration();
    //print's the topology
    print();
  endfunction
  
  //---------------------------------------
  // run_phase - starting the test
  //---------------------------------------
  task run_phase(uvm_phase phase);    
    phase.raise_objection(this);

    dma_seq.randomize();
    dma_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask : run_phase
  
endclass : dma_reg_test_random
