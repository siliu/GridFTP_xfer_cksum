#! /bin/bash


for i in {1..20}
do
	data10g=10G.data$i

	#10G data
	globus-url-copy ftp://cc034.fst.alcf.anl.gov:44686/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc083.fst.alcf.anl.gov:54769/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/
	globus-url-copy -sync -sync-level 3 ftp://cc034.fst.alcf.anl.gov:44686/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc083.fst.alcf.anl.gov:54769/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g &

done

wait
