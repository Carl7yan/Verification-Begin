UVM_HOME = /opt/uvm/uvm-1.2

filelist =  file
simv_name = simv
vdb_name = $(simv_name)
vpdpluse_name = vcdpluse
cov_file_name = coverage
export top_name = tb

#compile
NOR_VCS 	= vcs -full64 -sverilog +v2k -timescale=1ns/1ns \
						-full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -lpthread \
						-ucli -i dump_fsdb_vcs.tcl \
      			-debug_all \
      			+notimingcheck \
      			+nospecify \
      			+vcs+flush+all \
      			-o $(simv_name) \
      			-l compile.log \
						${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
						+incdir+${UVM_HOME}/src ${UVM_HOME}/src/uvm.sv \
						-top ${top_name} \
						-fsdb \
	  				-f $(filelist).f \
						#./simv -l ./vsim2.log


# run option
RUN_VPD = -R -gui +vpdfile+$(vpdpluse_name).vpd -l run.log
RUN_VER = -P /opt/synopsys/verdi2018/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64/novas.tab \
					/opt/synopsys/verdi2018/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64/pli.a \
					-R +fsdb+autoflush -l run.log
RUN_COV = -R -cm line+cond+fsm+branch+tgl \
					-cm_name $(vdb_name) -cm_dir ./$(cov_file_name) -l run.log

# compile with verdi
vc:
	$(NOR_VCS) $(RUN_VER)

# open verdi
vd:
	verdi +v2k -sv \
	+incdir+@{UVM_HOME}/src ${UVM_HOME}/src/uvm.sv  \
 	-f $(filelist).f -ssf *.fsdb -nologo &

# compile with dve
ve:
	$(NOR_VCS)  $(RUN_VPD)
	dve -vpd $(vpdpluse_name).vpd

# compile with coverage
cov:
	$(NOR_VCS) $(RUN_COV)
	dve -covdir $(cov_file_name).vdb

cn:
	rm -rf *~ core *csrc vc_hdrs.h ucli.key urg* *.log  *csrc ./*.daidir  *simv* DVE* ucli* *.vpd *.vdb *.log *.fsdb *novas* *.dat *Log *rc *conf

