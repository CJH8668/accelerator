.PHONY:com sim cov debug clean

OUTPUT = cpu_top
tbTop = tb_top
ALL_DEFINE = +define+DUMP_VPD	\
					 +define+DUMP_FSDB	
VPD_NAME = +vpdfile+${OUTPUT}.vpd

#compile command
VCS = vcs	-sverilog +v2k			\
					-timescale=1ns/1ps 	\
					-full64							\
					-fsdb								\
					-kdb -lca				    \
					+notimingcheck			\
					+nospecify          \
					-P /home/eda/synopsys/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/LINUXAMD64/novas.tab \
					/home/eda/synopsys/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/LINUXAMD64/pli.a        \
					+vcs+flush+all			\
	  				-debug_pp           \
	  				+vcd+vcdpluson      \
					-f ../scripts/FileList.f   \
					-o ${OUTPUT}   \
	  				$(ALL_DEFINE)       \
					-cm line+cond+fsm+tgl  \

#simulation command
SIM = 	./${OUTPUT} 			\
			-l ${OUTPUT}.log 			\
			${VPD_NAME} 			\
			-cm line+cond+fsm+tgl			\

#start compile
com:
	${VCS} 

#start simulation
sim:
	${SIM} 

#start debug command
debug:
	dve -vpd ${OUTPUT}.vpd &

#start verdi
verdi:
<<<<<<< HEAD
	# verdi +v2k -sverilog -top ${tbTop} -f ../scripts/FileList.f -ssf gemv_openmp.fsdb &
	verdi +v2k -sverilog -top ${tbTop} -f ../scripts/FileList.f -ssf hello_world.fsdb &
	# verdi +v2k -sverilog -top ${tbTop} -f ../scripts/FileList.f -ssf float.fsdb &
	
=======
	verdi +v2k -sverilog -top ${tbTop} -f ../scripts/FileList.f -ssf float2.fsdb &
	#verdi -dbdir ./${OUTPUT}.daidir &

>>>>>>> b9b049b3b7aa5eca2ca6fb021c014aad68c53a8d
#show the coverage
cov:
	dve -full64 -covdir *vdb &

#clean some file
clean:
	rm -rf ./verdiLog ./novas* ./*.fsdb ./csrc  *.daidir ./csrc *.log *.vpd *.vdb simv* *.key *race.out* ${OUTPUT}  DVEfiles
