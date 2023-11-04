class simpleadder_driver extends uvm_driver#(simpleadder_transaction);
  `uvm_component_utils(simpleadder_driver)

  typedef enum {WAIT_EN_I, READ_IN, SEND_OUT} sa_state;
  sa_state state1;

  protected virtual simpleadder_if vif;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    void'(uvm_resource_db#(virtual simpleadder_if)::read_by_name(.scope("ifs"), .name("simpleadder_if"), .val(vif)));
  endfunction

  task run_phase(uvm_phase phase);
    drive();
  endtask: run_phase

  virtual task drive();
    simpleadder_transaction sa_tx;
    integer counter = 0, state1 = WAIT_EN_I;
    vif.cb.sig_ina <= 1'b0;
    vif.cb.sig_inb <= 1'b0;
    vif.cb.sig_en_i <= 1'b0;
    
    forever begin
      if(counter == 0) begin
        seq_item_port.get_next_item(sa_tx);
      end

      @(vif.cb)
      begin
        //state 0: drives the signal en_0
        if(counter == 0) begin
          vif.cb.sig_en_i <= 1'b1;
          state1 = READ_IN;
        end

        if(counter == 1) begin
          vif.cb.sig_en_i <= 1'b0;
        end

        case(state1)
          //state 1: transimits ina and inb
          READ_IN: begin
            vif.cb.sig_ina <= sa_tx.ina[1];
            vif.cb.sig_inb <= sa_tx.inb[1];

            sa_tx.ina = sa_tx.ina << 1;
            sa_tx.inb = sa_tx.inb << 1;

            counter = counter + 1;
            if(counter == 2) state1 = 2;
          end

          //state 2: waits for the dut to respond
          SEND_OUT: begin
            vif.cb.sig_ina <= 1'b0;
            vif.cb.sig_inb <= 1'b0;
            counter = counter + 1;

            //
            if(counter == 6) begin
              counter = 0;
              state1 = 0;

              seq_item_port.item_done();
            end
          end
        endcase
      end

    end

  endtask
endclass: simpleadder_driver
