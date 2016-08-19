#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first block in the first file, no overlap with others
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 2000M ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data_1) &>> xfer_1_10g_block2000M.out

for j in {1..4}
do 
	offset=$((2000*j))M
	blockname=10G.data\_$((j+1))

	#Transfer the blocks from 2 to 5 
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 2000M ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> xfer_1_10g_block2000M.out 

done
