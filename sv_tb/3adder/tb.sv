module tb;
  bit tb_clk;
  clk_if    m_clk_if     ();
  adder_if  m_adder_if   ();
  my_adder  u0            (m_adder_if);

  initial begin
    test t0;
    t0 = new;

    t0.e0.m_adder_vif = m_adder_if;
    t0.e0.m_clk_vif = m_clk_if;
    t0.run();

   #50 $finish;
  end

  initial begin
    //$fsdbDumpfile("3adder.fsdb");
    //$fsdbDumpvars;
  end
endmodule
