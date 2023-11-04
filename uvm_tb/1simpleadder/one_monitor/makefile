UVM_HOME = /opt/uvm/uvm-1.2


#the source file's name is vlog_list.f then :make norsim src_list=file_list
src_list =  file
simv_name = simv
vpdpluse_name = vcdpluse
cov_file_name = coverage
vdb_name = $(simv_name)
top_name = "tb"

#compile
NOR_VCS = vcs -full64 -sverilog +v2k -timescale=1ns/1ns            \
					-full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -lpthread \
      -debug_all                               \
      +notimingcheck                                   \
      +nospecify                                       \
      +vcs+flush+all                                   \
      -o $(simv_name)   \
      -l compile.log	\
			${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
			+incdir+${UVM_HOME}/src ${UVM_HOME}/src/uvm.sv  \
			-top ${top_name}  \
			-fsdb \
	  	-f $(src_list).f  \
			#./simv -l ./vsim2.log

#coverage compile switch
COV_SW = -cm line+cond+fsm+branch+tgl

#verdi dump wave compile option
VERDI_SW = -P /opt/Synopsys/Verdi2018/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64/novas.tab \
		/opt/Synopsys/Verdi2018/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64/pli.a

#run option
RUN_GUI = -R -gui -l run.log
RUN_VPD = -R +vpdfile+$(vpdpluse_name).vpd -l run.log
RUN_COV = -R $(COV_SW) -cm_name $(vdb_name) -cm_dir ./$(cov_file_name) -l run.log
RUN_VER = -R +fsdb+autoflush -l run.log

vc1:
	$(NOR_VCS) $(VERDI_SW) $(RUN_VER)

vd:
	verdi +v2k -sv \
	+incdir+@{UVM_HOME}/src ${UVM_HOME}/src/uvm.sv  \
 	*v -ssf *.fsdb -nologo &






vc2:
	$(NOR_VCS) $(RUN_GUI)

ve:
	$(NOR_VCS)  $(RUN_VPD)
	dve -vpd $(vpdpluse_name).vpd

#coverage
covsim:
	$(NOR_VCS) $(COV_SW) $(RUN_COV)
	dve -covdir $(cov_file_name).vdb

cn:
	rm -rf *~ core *csrc vc_hdrs.h ucli.key urg* *.log  *csrc ./*.daidir  *simv* DVE* ucli* *.vpd *.vdb *.log *.fsdb *novas* *.dat *Log *rc *conf

