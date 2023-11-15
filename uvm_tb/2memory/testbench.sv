//-------------------------------------------------------------------------
//				www.verificationguide.com   testbench.sv
//-------------------------------------------------------------------------
//---------------------------------------------------------------
//including interfcae and testcase files
`include "mem_interface.sv"
`include "mem_base_test.sv"
`include "mem_wr_rd_test.sv"

`include "mem_test.sv"
`include "mem_write_test.sv"
`include "mem_read_test.sv"
`include "mem_write_read_test.sv"
//---------------------------------------------------------------

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //---------------------------------------
  //clock and reset signal declaration
  //---------------------------------------
  bit clk;
  bit reset;
  
  //---------------------------------------
  //clock generation
  //---------------------------------------
  always #5 clk = ~clk;
  
  //---------------------------------------
  //reset Generation
  //---------------------------------------
  initial begin
    reset = 1;
    #5 reset =0;
  end
  
  //---------------------------------------
  //interface instance
  //---------------------------------------
  mem_if intf(clk,reset);
  
  //---------------------------------------
  //DUT instance
  //---------------------------------------
  memory DUT (
    .clk(intf.clk),
    .reset(intf.reset),
    .addr(intf.addr),
    .wr_en(intf.wr_en),
    .rd_en(intf.rd_en),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
   );
  
  //---------------------------------------
  //passing the interface handle to lower heirarchy using set method 
  //and enabling the wave dump
  //---------------------------------------
  initial begin 
    uvm_config_db#(virtual mem_if)::set(uvm_root::get(),"*","vif",intf);
    //enable wave dump
    //$dumpfile("dump.vcd"); 
    //$dumpvars;
    $vcdpluson;
    $vcdplusdeltacycleon;
  end
  
  //---------------------------------------
  //calling test
  //---------------------------------------
  initial begin 
    run_test("mem_test");
  end
  
endmodule
