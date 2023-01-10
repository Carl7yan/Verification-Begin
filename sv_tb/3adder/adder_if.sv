interface adder_if();
  logic       rstn;
  logic [7:0] a;
  logic [7:0] b;
  logic [7:0] sum;
  logic       carry;
endinterface

// Create a mock clock used in the TB to synchronize when value is driven and when value is sampled
// Typically combinational logic is used between sequential elements like FF in a real circuit, 
// so let's assume that inputs to the adder is provided at some posedge clock
// but the DUT doesn't have clock in its input, so we keep this clock in a separate interface that is available only in the TB
interface clk_if();
  logic tb_clk;

  initial tb_clk <= 0;
  always #10 tb_clk = ~tb_clk;
endinterface
