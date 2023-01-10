// the design simple adds inputs to give sum and carry
// scoreboard helps to check if the ouput has changed for given set of inputs based on expectd logic
class scoreboard;
  mailbox scb_mbx;

  task run();
    forever begin
      Packet item, ref_item;
      scb_mbx.get(item);
      item.print("Scoreboard");

      // copy received packet into a new packet
      ref_item = new();
      ref_item.copy(item);

      // calculate the expected values in carry and sum
      if (ref_item.rstn)
        {ref_item.carry, ref_item.sum} = ref_item.a + ref_item.b;
      else
        {ref_item.carry, ref_item.sum} = 0;

      // compare carry and sum outputs in the reference model with those in the received packet
      if (ref_item.carry != item.carry) begin
        $display("[%0t] Scoreboard Error! Carry mismatch ref_item=0x%0h item=0x%0h", $time, ref_item.carry, item.carry);
      end else begin $display("[%0t] Scoreboard Pass! Carry match ref_item=0x%0h item=0x%0h", $time, ref_item.carry, item.carry);
      end

      if(ref_item.sum != item.sum) begin
        $display("[%0t] Scoreboard Error! Sum mismatch ref_item=0x%0h item=0x%0h", $time, ref_item.sum, item.sum);
      end else begin
        $display("[%0t Scoreboard Pass! Sum match ref_item=0x%0h item=0x%0h", $time, ref_item.sum, item.sum);
      end
    end
  endtask
endclass
