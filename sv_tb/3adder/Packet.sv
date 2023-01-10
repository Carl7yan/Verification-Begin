// check that it does not add when rstn is 0
// and hence rstn should also be arndomized along with a and b
class Packet;
  rand bit       rstn;
  rand bit [7:0] a;
  rand bit [7:0] b;
  bit [7:0]     sum;
  bit           carry;

  function void print(string tag="");
    $display ("T=%0t %s a=0x%0h b=0x%0h sum=0x%0h carry=0x%0h", $time, tag, a, b, sum, carry);
  endfunction

  function void copy(Packet tmp);
    this.a = tmp.a;
    this.b = tmp.b;
    this.rstn = tmp.rstn;
    this.sum = tmp.sum;
    this.carry = tmp.carry;
  endfunction
endclass
