#! /bin/bash

#Transfer the first file, no overlap with others
globus-url-copy ftp://cc034.fst.alcf.anl.gov:44686/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc083.fst.alcf.anl.gov:54769/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/

for i in {1..19}
do
	data10g=10G.data$i
	data10g_next=10G.data$((i+1))

	#Compute the cksum of 10G file from 1 to 19
	globus-url-copy -sync -sync-level 3 ftp://cc034.fst.alcf.anl.gov:44686/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc083.fst.alcf.anl.gov:54769/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g &
	#Transfer the 10G file from 2 to 20
	globus-url-copy ftp://cc034.fst.alcf.anl.gov:44686/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc083.fst.alcf.anl.gov:54769/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/
	wait

done

#Compute the cksum of the last 10G file
globus-url-copy -sync -sync-level 3 ftp://cc034.fst.alcf.anl.gov:44686/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc083.fst.alcf.anl.gov:54769/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data20

wait
