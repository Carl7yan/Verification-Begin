import uvm_pkg::*;
module tb;
  simpleadder_if vif();
  simpleadder dut(
                 .clk(vif.sig_clock)
                ,.en_i(vif.sig_en_i)
                ,.ina(vif.sig_ina)
                ,.inb(vif.sig_inb)
                ,.en_o(vif.sig_en_o)
                ,.out(vif.sig_out));

  initial vif.sig_clock <= 1;
  always #5 vif.sig_clock <= ~vif.sig_clock;

  initial begin
    uvm_resource_db#(virtual simpleadder_if)::set(.scope("ifs"), .name("simpleadder_if"), .val(vif));
    run_test("simpleadder_test");
  end

  initial begin
    $fsdbDumpfile("sa.fsdb");
    $fsdbDumpvars(0);
    $vcdpluson;
  end
endmodule
