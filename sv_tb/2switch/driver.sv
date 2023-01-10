class driver;
  virtual switch_if vif;
  event drv_done;
  mailbox drv_mbx;

  task run();
    $display("T=%0t [Driver] starting ...", $time);
    @(posedge vif.clk);

    forever begin
      switch_item item;

      $display ("T=%0t [Driver] waiting for item ...", $time);
      drv_mbx.get(item);
      item.print("Driver");
      vif.vld <= 1;
      vif.addr <= item.addr;
      vif.data <= item.data;

      @ (posedge vif.clk);
      vif.vld <= 0; ->drv_done;
    end
  endtask: run
endclass: driver
