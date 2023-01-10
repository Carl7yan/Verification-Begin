debImport "+v2k" "-sv" "+incdir+@\{UVM_HOME\}/src" "/opt/uvm/uvm-1.2/src/uvm.sv" \
          "simpleadder_agent.sv" "simpleadder_config.sv" \
          "simpleadder_driver.sv" "simpleadder_env.sv" "simpleadder_if.sv" \
          "simpleadder_monitor_after.sv" "simpleadder_monitor.sv" \
          "simpleadder_pkg.sv" "simpleadder_scoreboard.sv" \
          "simpleadder_sequencer.sv" "simpleadder_tb.sv" "simpleadder_test.sv" \
          "simpleadder.v" "simple_transaction_3inputs.sv" "simv"
debLoadSimResult /home/icer/Desktop/fundamentals/verify/1simpleadder/sa.fsdb
wvCreateWindow
srcHBSelect "tb.vif" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvRenameGroup -win $_nWave2 {G1} {vif(simpleadder_if)}
wvAddSignal -win $_nWave2 "/tb/vif/sig_clock" "/tb/vif/sig_en_i" \
           "/tb/vif/sig_ina" "/tb/vif/sig_inb" "/tb/vif/sig_en_o" \
           "/tb/vif/sig_out"
wvSetPosition -win $_nWave2 {("vif(simpleadder_if)" 0)}
wvSetPosition -win $_nWave2 {("vif(simpleadder_if)" 6)}
wvSetPosition -win $_nWave2 {("vif(simpleadder_if)" 6)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetCursor -win $_nWave2 32.660207 -snap {("G2" 0)}
wvSelectGroup -win $_nWave2 {G2}
wvSetCursor -win $_nWave2 25.652653 -snap {("G2" 0)}
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 5 )} 
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 4 )} 
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 2 )} 
wvSelectGroup -win $_nWave2 {vif(simpleadder_if)}
wvSelectGroup -win $_nWave2 {vif(simpleadder_if)}
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 2 )} 
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 4 )} 
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 5 )} 
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 6 )} 
wvSelectGroup -win $_nWave2 {G2}
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 6 )} 
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 5 )} 
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 3 )} 
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 2 )} 
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 1 )} 
wvSelectSignal -win $_nWave2 {( "vif(simpleadder_if)" 1 )} 
wvSelectGroup -win $_nWave2 {vif(simpleadder_if)}
debExit
