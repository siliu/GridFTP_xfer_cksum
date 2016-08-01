#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Deal with files from 1 to 19
for i in {1..20}
do
	data10g=10G.data$i

	#10G data
	for j in {0..4}
	do 
		offset=$((2000*j))M
		blockname=$data10g\_$((j+1))
		
		#Transfer the blocks from 1 to 5 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 2000M ftp://cc106.fst.alcf.anl.gov:41794/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc013.fst.alcf.anl.gov:48045/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> seq_block_xfer_20_10g_block2G.out 
	 
		#Compute the checksum of blocks from 1 to 5 of file i	
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 2000M -sync -sync-level 3 ftp://cc106.fst.alcf.anl.gov:41794/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc013.fst.alcf.anl.gov:48045/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname)  &>> seq_block_xfer_20_10g_cksum_block2G.out
	
	done
	
done

