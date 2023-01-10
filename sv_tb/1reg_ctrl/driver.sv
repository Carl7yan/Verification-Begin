class driver;
    virtual reg_if vif;
    event drv_done;
    mailbox drv_mbx; 

    task run();
        $display ("T=%0t [Driver] starting ...", $time);
        @(posedge vif.clk); // try to get a new transaction every clk
            forever begin
                reg_item item;
                $display("T=%0t [Driver] waiting for item ...", $time);
                drv_mbx.get(item); // get a transaction from mailbox if it's available
                item.print("Driver");

                // drive the transaction out into DUT interface
                vif.sel <= 1;
                vif.addr <= item.addr;
                vif.wr <= item.wr;
                vif.wdata <= item.wdata;

                // wait for the DUT is ready to accept new transactions
                @(posedge vif.clk);
                    while(!vif.ready) begin
                        $display("T=%0t [Driver] wait until ready is high", $time);
                        @(posedge vif.clk);
                    end

                // when transfor is over, raise the event
                vif.sel <= 0;
                ->drv_done;
            end
    endtask
endclass
