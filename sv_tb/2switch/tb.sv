module tb;
  reg clk;

  always #10 clk = ~clk;

  switch_if _if(clk);
  switch u0 ( .clk(clk)
             ,.rstn(_if.rstn)
             ,.addr(_if.addr)
             ,.data(_if.data)
             ,.vld(_if.vld)
             ,.addr_a(_if.addr_a)
             ,.data_a(_if.data_a)
             ,.addr_b(_if.addr_b)
             ,.data_b(_if.data_b)
  );


  initial begin
    test t0;

    // apply reset and start stimulus
    {clk, _if.rstn} <= 0;
    #20 _if.rstn <= 1;
    t0 = new;
    t0.e0.vif = _if;
    t0.run();

    #50 $finish;
  end

  initial begin
    //$fsdbDumpvars;
    //$fsdbDumpfile("switch.fsdb");
  end
endmodule: tb
