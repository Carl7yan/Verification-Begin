interface des_if (input bit clk);
  logic rstn;
  logic in;
  logic out;

  clocking cb @(posedge clk);
    default input #1ns output #1ns;
      input out;
      output in;
  endclocking
endinterface
