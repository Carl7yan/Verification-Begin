class env;
    driver     d0;
    monitor    m0;
    scoreboard s0;
    mailbox    scb_mbx; //top level mailbox for scb <-> mon
    virtual reg_if  vif;    //virtual interface handle

    //instantiate all tb components
    function new();
        d0 = new;
        m0 = new;
        s0 = new;
        scb_mbx = new();
    endfunction

    //assign handles and start all components so that
    //they all become active and wait for transactions available
    virtual task run();
        d0.vif = vif;
        m0.vif = vif;
        m0.scb_mbx = scb_mbx;
        s0.scb_mbx = scb_mbx;

        fork
            s0.run();
            d0.run();
            m0.run();
        join_any
    endtask
endclass
