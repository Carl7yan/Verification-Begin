//-------------------------------------------------------------------------
//				www.verificationguide.com   testbench.sv
//-------------------------------------------------------------------------
//---------------------------------------------------------------
//including interfcae and testcase files

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "dma_sfr_defines.sv"
`include "dma_interface.sv"
`include "dma_tests.sv"
//---------------------------------------------------------------

module tb;

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
  dma_if intf(clk,reset);
  
  //---------------------------------------
  //DUT instance
  //---------------------------------------
  DMA DUT (
    .clk(intf.clk),
    .reset(intf.reset),
    .addr(intf.addr),
    .wr_en(intf.wr_en),
    .valid(intf.valid),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
   );
  
  //---------------------------------------
  //passing the interface handle to lower heirarchy using set method 
  //and enabling the wave dump
  //---------------------------------------
  initial begin 
    uvm_config_db#(virtual dma_if)::set(uvm_root::get(),"*","vif",intf);
    //enable wave dump
    // $dumpfile("dump.vcd"); 
    // $dumpvars;
    $vcdpluson;
  end
  
  //---------------------------------------
  //calling test
  //---------------------------------------
  initial begin 
    run_test("dma_reg_test_random");
  end
  
endmodule
