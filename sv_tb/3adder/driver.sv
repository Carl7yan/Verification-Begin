class driver;
  virtual adder_if m_adder_vif;
  virtual clk_if m_clk_vif;
  event drv_done;
  mailbox drv_mbx;

  task run();
    $display ("T=%0t [Driver] starting ...", $time);
    forever begin
      Packet item;
      $display ("T=%0t [Driver] waiting for item ...", $time);
      drv_mbx.get(item);
      @ (posedge m_clk_vif.tb_clk);
      item.print("Driver");
      m_adder_vif.rstn <= item.rstn;
      m_adder_vif.a <= item.a;
      m_adder_vif.b <= item.b; 
      ->drv_done;
    end
  endtask
endclass
