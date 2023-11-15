class simpleadder_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(simpleadder_scoreboard)

  uvm_analysis_export #(simpleadder_transaction) sb_export;

  uvm_tlm_analysis_fifo #(simpleadder_transaction) _fifo;

  simpleadder_transaction transaction;
  simpleadder_transaction transaction_ref;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    transaction = new("transaction");
    transaction_ref = new("transaction_ref");
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_export = new("sb_export", this);

    _fifo   = new("_fifo", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    sb_export.connect(_fifo.analysis_export);
  endfunction: connect_phase

  task run();
    forever
      begin
        _fifo.get(transaction);
        transaction_ref.copy(transaction);
        predictor();
        compare();
      end
  endtask: run

   virtual function void predictor();
      transaction_ref.out = transaction_ref.ina + transaction_ref.inb;
    endfunction

  virtual function void compare();
  if(transaction.out == transaction_ref.out) begin
      `uvm_info("compare", {"Test: OK!"}, UVM_LOW);
    end else begin
      `uvm_info("compare", {"Test: Fail!"}, UVM_LOW);
    end
  endfunction: compare
endclass: simpleadder_scoreboard
