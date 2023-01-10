class gen_item_seq extends uvm_sequence;
  `uvm_object_utils(gen_item_seq)
  function new(string name="gen_item_seq");
    super.new(name);
  endfunction

  rand int num;

  constraint c1 { 
      soft num inside {[10:50]};}

  virtual task body();
    for (int i = 0; i < num; i++) begin
      Item m_item = Item::type_id::create("m_item");

      start_item(m_item);
      m_item.randomize();
      
      `uvm_info("SEQ", $sformatf("Generate new item: %s", m_item.convert2str()), UVM_HIGH)
      finish_item(m_item);
    end
    `uvm_info("SEQ", $sformatf("Done generation of %0d items", num), UVM_LOW)
  endtask
endclass

// --------------------------------------------
// sequence 1011011
// --------------------------------------------
class seq_1011011 extends uvm_sequence;
  `uvm_object_utils(seq_1011011)
  function new(string name="seq_1011011");
    super.new(name);
  endfunction

  rand int num;

  constraint c1 { 
      soft num == 1;}

  virtual task body();
    for (int i = 0; i < num; i++) begin
      Item m_item = Item::type_id::create("m_item");

      start_item(m_item);
      m_item.in = 1;
      `uvm_info("SEQ", $sformatf("Generate new item: %s", m_item.convert2str()), UVM_HIGH)
      finish_item(m_item);

      start_item(m_item);
      m_item.in = 0;
      `uvm_info("SEQ", $sformatf("Generate new item: %s", m_item.convert2str()), UVM_HIGH)
      finish_item(m_item);

      start_item(m_item);
      m_item.in = 1;
      `uvm_info("SEQ", $sformatf("Generate new item: %s", m_item.convert2str()), UVM_HIGH)
      finish_item(m_item);

      start_item(m_item);
      m_item.in = 1;
      `uvm_info("SEQ", $sformatf("Generate new item: %s", m_item.convert2str()), UVM_HIGH)
      finish_item(m_item);

      start_item(m_item);
      m_item.in = 0;
      `uvm_info("SEQ", $sformatf("Generate new item: %s", m_item.convert2str()), UVM_HIGH)
      finish_item(m_item);

      start_item(m_item);
      m_item.in = 1;
      `uvm_info("SEQ", $sformatf("Generate new item: %s", m_item.convert2str()), UVM_HIGH)
      finish_item(m_item);

      start_item(m_item);
      m_item.in = 1;
      `uvm_info("SEQ", $sformatf("Generate new item: %s", m_item.convert2str()), UVM_HIGH)
      finish_item(m_item);
    end

    `uvm_info("SEQ", $sformatf("Done generation of %0d items", num), UVM_LOW)
  endtask

endclass
