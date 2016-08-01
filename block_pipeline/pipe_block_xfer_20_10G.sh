#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first block in the first file, no overlap with others
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 2000M ftp://cc122.fst.alcf.anl.gov:36994/scratch/md5_data/10G.data1 ftp://cc062.fst.alcf.anl.gov:52651/scratch/checksum_tests/10G.data1_1) &>> pipe_block_xfer_20_10g_block2G.out

#Deal with files from 1 to 19
for i in {1..19}
do
	data10g=10G.data$i
	data10g_next=10G.data$((i+1))

	#10G data
	for j in {0..3}
	do 
		offset=$((2000*j))M
		blockname=$data10g\_$((j+1))
		offset_next=$((2000*(j+1)))M
		blockname_next=$data10g\_$((j+2))
		
		#Compute the checksum of blocks from 1 to 4 of file i	
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 2000M -sync -sync-level 3 ftp://cc122.fst.alcf.anl.gov:36994/scratch/md5_data/$data10g ftp://cc062.fst.alcf.anl.gov:52651/scratch/checksum_tests/$blockname)  &>> pipe_block_xfer_20_10g_cksum_block2G.out &
		#Transfer the blocks from 2 to 5 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 2000M ftp://cc122.fst.alcf.anl.gov:36994/scratch/md5_data/$data10g ftp://cc062.fst.alcf.anl.gov:52651/scratch/checksum_tests/$blockname_next) &>> pipe_block_xfer_20_10g_block2G.out 
	 
		wait
	
	done
	
	#Compute the last block checksum of file i
	 (time $GRIDFTP_PATH/globus-url-copy -p 1 -off 8000M -len 2000M -sync -sync-level 3 ftp://cc122.fst.alcf.anl.gov:36994/scratch/md5_data/$data10g ftp://cc062.fst.alcf.anl.gov:52651/scratch/checksum_tests/$data10g\_5) &>> pipe_block_xfer_20_10g_cksum_block2G.out  &
	#Transfer the first block of file i+1
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 2000M ftp://cc122.fst.alcf.anl.gov:36994/scratch/md5_data/$data10g_next ftp://cc062.fst.alcf.anl.gov:52651/scratch/checksum_tests/$data10g_next\_1) &>> pipe_block_xfer_20_10g_block2G.out

	wait

done

#Deal with the last file, file No. 20
for j in {0..3}
do
	offset=$((2000*j))M
	blockname=10G.data20_$((j+1))
	offset_next=$((2000*(j+1)))M
	blockname_next=10G.data20\_$((j+2))

	#Compute the checksum of blocks from 1 to 4 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 2000M -sync -sync-level 3 ftp://cc122.fst.alcf.anl.gov:36994/scratch/md5_data/10G.data20 ftp://cc062.fst.alcf.anl.gov:52651/scratch/checksum_tests/$blockname) &>> pipe_block_xfer_20_10g_cksum_block2G.out  &
	#Transfer the blocks from 2 to 5 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 2000M ftp://cc122.fst.alcf.anl.gov:36994/scratch/md5_data/10G.data20 ftp://cc062.fst.alcf.anl.gov:52651/scratch/checksum_tests/$blockname_next) &>> pipe_block_xfer_20_10g_block2G.out 

	wait

done

#Compute the cksum of the last block of the last 10G file
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 8000M -len 2000M -sync -sync-level 3 ftp://cc122.fst.alcf.anl.gov:36994/scratch/md5_data/10G.data20 ftp://cc062.fst.alcf.anl.gov:52651/scratch/checksum_tests/10G.data20_5) &>> pipe_block_xfer_20_10g_cksum_block2G.out

wait
