#! /bin/bash

#In this version, each stage doesn't wait until the previous stage to finish to start
#We should make sure that each only has one stage

for i in {1..10}
do
	data10g=10G.data$i
	data10m=10M.data$i

	#10G data
	for j in {0..19}
	do 
		offsite=$((500*j))M
		blockname=$data10g\_$((j+1))
		#echo $blockname
		(time globus-url-copy -off $offsite -len 500M ftp://cc018.fst.alcf.anl.gov:49182/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc102.fst.alcf.anl.gov:38103/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> pipe_block_xfer_data10g_time.out
		
		(time globus-url-copy -off $offsite -len 500M -sync -sync-level 3 ftp://cc018.fst.alcf.anl.gov:49182/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc102.fst.alcf.anl.gov:38103/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> pipe_block_xfer_data10g_cksum_time.out  &
	done

	#10M data
	(time globus-url-copy ftp://cc018.fst.alcf.anl.gov:49182/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc102.fst.alcf.anl.gov:38103/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_block_xfer_data10m_time.out

	(time globus-url-copy -sync -sync-level 3 ftp://cc018.fst.alcf.anl.gov:49182/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc102.fst.alcf.anl.gov:38103/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10m) &>> pipe_block_xfer_data10m_cksum_time.out  &

done
