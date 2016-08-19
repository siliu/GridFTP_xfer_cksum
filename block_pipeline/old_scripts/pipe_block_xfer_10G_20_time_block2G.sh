#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first block in the first file, no overlap with others
<<<<<<< HEAD
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 2000M ftp://cc107.fst.alcf.anl.gov:44492/scratch/md5_data/10G.data1 ftp://cc074.fst.alcf.anl.gov:37037/scratch/checksum_tests/10G.data1) &>> pipe_block_xfer_20_10g_block2G.out
=======
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 2000M ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data1_1) &>> pipe_block_xfer_20_10g_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

#Deal with files from 1 to 19
for i in {1..19}
do
	data10g=10G.data$i
	data10g_next=10G.data$((i+1))

	#10G data
	for j in {0..3}
	do 
		offset=$((2000*j))M
<<<<<<< HEAD
		#blockname=$data10g\_$((j+1))
		offset_next=$((2000*(j+1)))M
		#blockname_next=$data10g\_$((j+2))
		
		#Compute the checksum of blocks from 1 to 4 of file i	
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 2000M -sync  -sync-level 3 ftp://cc107.fst.alcf.anl.gov:44492/scratch/md5_data/$data10g ftp://cc074.fst.alcf.anl.gov:37037/scratch/checksum_tests/$data10g)  &>> pipe_block_xfer_20_10g_cksum_block2G.out &
		#Transfer the blocks from 2 to 5 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 2000M ftp://cc107.fst.alcf.anl.gov:44492/scratch/md5_data/$data10g ftp://cc074.fst.alcf.anl.gov:37037/scratch/checksum_tests/$data10g) &>> pipe_block_xfer_20_10g_block2G.out 
=======
		blockname=$data10g\_$((j+1))
		offset_next=$((2000*(j+1)))M
		blockname_next=$data10g\_$((j+2))
		
		#Compute the checksum of blocks from 1 to 4 of file i	
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 2000M -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname)  &>> pipe_block_xfer_20_10g_cksum_time.out &
		#Transfer the blocks from 2 to 5 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 2000M ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_20_10g_time.out 
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e
	 
		wait
	
	done
	
	#Compute the last block checksum of file i
<<<<<<< HEAD
	 (time $GRIDFTP_PATH/globus-url-copy -p 1 -off 8000M -len 2000M -sync -sync-level 3 ftp://cc107.fst.alcf.anl.gov:44492/scratch/md5_data/$data10g ftp://cc074.fst.alcf.anl.gov:37037/scratch/checksum_tests/$data10g) &>> pipe_block_xfer_20_10g_cksum_block2G.out  &
	#Transfer the first block of file i+1
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 2000M ftp://cc107.fst.alcf.anl.gov:44492/scratch/md5_data/$data10g_next ftp://cc074.fst.alcf.anl.gov:37037/scratch/checksum_tests/$data10g_next) &>> pipe_block_xfer_20_10g_block2G.out
=======
	 (time $GRIDFTP_PATH/globus-url-copy -p 1 -off 8000M -len 2000M -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g\_5) &>> pipe_block_xfer_20_10g_cksum_time.out  &
	#Transfer the first block of file i+1
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 2000M ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g_next\_1) &>> pipe_block_xfer_20_10g_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

	wait

done

#Deal with the last file, file No. 20
for j in {0..3}
do
	offset=$((2000*j))M
<<<<<<< HEAD
	#blockname=10G.data20_$((j+1))
	offset_next=$((2000*(j+1)))M
	#blockname_next=10G.data20\_$((j+2))

	#Compute the checksum of blocks from 1 to 4 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 2000M -sync -sync-level 3 ftp://cc107.fst.alcf.anl.gov:44492/scratch/md5_data/10G.data20 ftp://cc074.fst.alcf.anl.gov:37037/scratch/checksum_tests/10G.data20) &>> pipe_block_xfer_20_10g_cksum_block2G.out  &
	#Transfer the blocks from 2 to 5 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 2000M ftp://cc107.fst.alcf.anl.gov:44492/scratch/md5_data/10G.data20 ftp://cc074.fst.alcf.anl.gov:37037/scratch/checksum_tests/10G.data20) &>> pipe_block_xfer_20_10g_block2G.out 
=======
	blockname=10G.data20_$((j+1))
	offset_next=$((2000*(j+1)))M
	blockname_next=10G.data20\_$((j+2))

	#Compute the checksum of blocks from 1 to 4 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 2000M -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> pipe_block_xfer_20_10g_cksum_time.out  &
	#Transfer the blocks from 2 to 5 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 2000M ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_20_10g_time.out 
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

	wait

done

#Compute the cksum of the last block of the last 10G file
<<<<<<< HEAD
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 8000M -len 2000M  -sync -sync-level 3 ftp://cc107.fst.alcf.anl.gov:44492/scratch/md5_data/10G.data20 ftp://cc074.fst.alcf.anl.gov:37037/scratch/checksum_tests/10G.data20) &>> pipe_block_xfer_20_10g_cksum_block2G.out
=======
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 8000M -len 2000M -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data20_5) &>> pipe_block_xfer_20_10g_cksum_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

wait
