#! /bin/bash

for i in {1..20}
do
	data10g=10G.data$i

	#Transfer the 10G file from 1 to 20
	(time globus-url-copy ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> xfer_20_10G.out

done


