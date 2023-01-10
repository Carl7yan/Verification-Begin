class monitor;
    virtual reg_if vif;
    mailbox scb_mbx; // connect to scoreboard

    task run();
        $display("T=%0t [Monitor] starting ...", $time);

        // check if there is a valid transaction every clk
        forever begin
            @(posedge vif.clk);
                if(vif.sel) begin
                    // capture info into a packet
                  reg_item item = new;
                  item.addr = vif.addr;
                  item.wr = vif.wr;
                  item.wdata = vif.wdata;

                  if(!vif.wr) begin
                      @(posedge vif.clk);
                          item.rdata = vif.rdata;
                  end
                  item.print("Monitor");
                  // send the packet to the scoreboard
                  scb_mbx.put(item);
                end
        end
    endtask
endclass
