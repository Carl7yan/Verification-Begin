class simpleadder_transaction_3inputs extends simpleadder_transaction;
  rand bit [1:0] inc;
  function new(string name = "");
    super.new();
  endfunction

  `uvm_object_utils_begin(simpleadder_transaction_3inputs)
    `uvm_field_int(inc, UVM_ALL_ON)
  `uvm_object_utils_end
endclass: simpleadder_transaction_3inputs
