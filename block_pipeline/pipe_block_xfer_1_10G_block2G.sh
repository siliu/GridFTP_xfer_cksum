#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first block in the first file, no overlap with others
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 2G ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data_1) &>> pipe_block_xfer_1_10g_block2G.out


for j in {0..3}
do 
	offset=$((2*j))G
	blockname=10G.data\_$((j+1))
	offset_next=$((2*(j+1)))G
	blockname_next=10G.data\_$((j+2))

	#Compute the checksum of blocks from 1 to 4 	
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 2G -sync -sync-level 3 ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname)  &>> pipe_block_xfer_1_10g_cksum_block2G.out &
	
	#Transfer the blocks from 2 to 5 
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 2G ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_1_10g_block2G.out 

	wait

done
	
#Compute the last block checksum 
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 8G -len 2G -sync -sync-level 3 ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data\_5) &>> pipe_block_xfer_1_10g_cksum_block2G.out  &


wait
