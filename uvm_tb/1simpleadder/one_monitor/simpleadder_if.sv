interface simpleadder_if;
  logic   sig_clock;
  logic   sig_en_i;
  logic   sig_ina;
  logic   sig_inb;
  logic   sig_en_o;
  logic   sig_out;

  clocking cb @(posedge sig_clock);
    default input #1ns output #1ns;
    inout   sig_en_i;
    inout sig_ina;
    inout sig_inb;
    input  sig_en_o;
    input  sig_out;
  endclocking


endinterface: simpleadder_if
