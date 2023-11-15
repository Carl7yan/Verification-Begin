class simpleadder_monitor extends uvm_monitor;
  `uvm_component_utils(simpleadder_monitor)
  uvm_analysis_port#(simpleadder_transaction) mon_ap;
  virtual simpleadder_if vif;

  simpleadder_transaction sa_tx_cg;
  covergroup simpleadder_cg;
    ina_cp:   coverpoint sa_tx_cg.ina;
    inb_cp:   coverpoint sa_tx_cg.inb;
    cross ina_cp, inb_cp;
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    simpleadder_cg = new;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    void'(uvm_resource_db#(virtual simpleadder_if)::read_by_name(.scope("ifs"), .name("simpleadder_if"), .val(vif)));
    mon_ap = new(.name("mon_ap"), .parent(this));
  endfunction

  task run_phase(uvm_phase phase);
    integer counter_mon = 0, state = 0;

    simpleadder_transaction sa_tx;

    sa_tx = simpleadder_transaction::type_id::create(.name("sa_tx"), .contxt(get_full_name()));

    forever begin
      @(vif.cb) begin

        if(vif.cb.sig_en_i==1'b1) begin
					state = 1;
					sa_tx.ina = 2'b00;
					sa_tx.inb = 2'b00;
					sa_tx.out = 3'b000;
				end
				if(state==1) begin
					sa_tx.ina = sa_tx.ina << 1;
					sa_tx.inb = sa_tx.inb << 1;

					sa_tx.ina[0] = vif.cb.sig_ina;
					sa_tx.inb[0] = vif.cb.sig_inb;

					counter_mon = counter_mon + 1;

					if(counter_mon==2) begin
						state = 0;
						counter_mon = 0;

						sa_tx_cg = sa_tx;
						simpleadder_cg.sample();
					end
				end

        repeat(2) @(vif.cb); // 2 cycle later

        if(vif.cb.sig_en_o == 1'b1) begin
            state = 3;
        end
        if(state==3) begin
            sa_tx.out = sa_tx.out << 1;
            sa_tx.out[0] = vif.cb.sig_out;

            counter_mon = counter_mon + 1;

            if(counter_mon==3) begin
                state = 0;
                counter_mon = 0;
            end
        end

        mon_ap.write(sa_tx);

      end
    end
  endtask: run_phase
endclass
