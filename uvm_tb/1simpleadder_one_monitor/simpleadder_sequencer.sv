class simpleadder_transaction extends uvm_sequence_item;
  rand bit [1:0] ina;
  rand bit [1:0] inb;
  bit [2:0] out;

  function new(string name = "");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(simpleadder_transaction)
    `uvm_field_int(ina, UVM_ALL_ON)
    `uvm_field_int(inb, UVM_ALL_ON)
    `uvm_field_int(out, UVM_ALL_ON)
  `uvm_object_utils_end
endclass: simpleadder_transaction


class simpleadder_sequence extends uvm_sequence#(simpleadder_transaction);
  `uvm_object_utils(simpleadder_sequence)

  function new(string name = "");
    super.new();
  endfunction

  task body();
    simpleadder_transaction sa_tx;

    repeat(15) begin
      sa_tx = simpleadder_transaction::type_id::create(.name("sa_tx"), .contxt(get_full_name()));
      start_item(sa_tx);
      assert(sa_tx.randomize());
      finish_item(sa_tx);
    end

  endtask: body
endclass: simpleadder_sequence

class simpleadder_sequence2 extends uvm_sequence#(simpleadder_transaction);
  `uvm_object_utils(simpleadder_sequence2)

  function new(string name = "");
    super.new();
  endfunction

  task body();
    simpleadder_transaction sa_tx;
    repeat(2) begin
      sa_tx = simpleadder_transaction::type_id::create(.name("sa_tx"), .contxt(get_full_name()));
      start_item(sa_tx);
      sa_tx.ina = 'b00;
      sa_tx.inb = 'b01;
      finish_item(sa_tx);
    end
  endtask: body
endclass: simpleadder_sequence2


typedef uvm_sequencer#(simpleadder_transaction) simpleadder_sequencer;
