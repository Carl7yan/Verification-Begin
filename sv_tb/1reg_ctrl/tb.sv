module tb;
    reg clk;

    always #10 clk = ~clk;
    reg_if _if (clk);

    reg_ctr1 u0 (   .clk(clk),
                    .addr(_if.addr),
                    .rstn(_if.rstn),
                    .sel(_if.sel),
                    .wr(_if.wr),
                    .wdata(_if.wdata),
                    .rdata(_if.rdata),
                    .ready(_if.ready)
                );

    initial 
    begin
        test t0;

        clk <= 0;
        _if.rstn <= 0;
        _if.sel <= 0;

        #20
        _if.rstn <= 1;

        // Start test once the DUT comes out of reset
        // Or the reset can also be a part of the test class
        t0 = new;
        t0.e0.vif = _if;
        t0.run();
        
        // once the main stimulus is over
        // wait for some time until all transactions are finished and then end simulation
        #200
        $finish;
    end

    initial
    begin
        //$fsdbDumpvars;
        //$fsdbDumpfile("1reg_ctrl.fsdb");
    end

endmodule
