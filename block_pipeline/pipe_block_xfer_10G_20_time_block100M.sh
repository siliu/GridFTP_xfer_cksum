#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first block in the first file, no overlap with others
<<<<<<< HEAD
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 100M ftp://cc075.fst.alcf.anl.gov:46040/scratch/md5_data/10G.data1 ftp://cc073.fst.alcf.anl.gov:48099/scratch/checksum_tests/10G.data1) &>> pipe_block_xfer_20_10g_block100M.out
=======
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 100M ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data1_1) &>> pipe_block_xfer_20_10g_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

#Deal with files from 1 to 19
for i in {1..19}
do
	data10g=10G.data$i
	data10g_next=10G.data$((i+1))

	#10G data
	for j in {0..98}
	do 
		offset=$((100*j))M
<<<<<<< HEAD
		#blockname=$data10g\_$((j+1))
		offset_next=$((100*(j+1)))M
		#blockname_next=$data10g\_$((j+2))
		
		#Compute the checksum of blocks from 1 to 99 of file i	
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 100M -sync -sync-level 3 ftp://cc075.fst.alcf.anl.gov:46040/scratch/md5_data/$data10g ftp://cc073.fst.alcf.anl.gov:48099/scratch/checksum_tests/$data10g)  &>> pipe_block_xfer_20_10g_cksum_block100M.out &
		#Transfer the blocks from 2 to 100 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 100M ftp://cc075.fst.alcf.anl.gov:46040/scratch/md5_data/$data10g ftp://cc073.fst.alcf.anl.gov:48099/scratch/checksum_tests/$data10g) &>> pipe_block_xfer_20_10g_block100M.out 
=======
		blockname=$data10g\_$((j+1))
		offset_next=$((100*(j+1)))M
		blockname_next=$data10g\_$((j+2))
		
		#Compute the checksum of blocks from 1 to 99 of file i	
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 100M -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname)  &>> pipe_block_xfer_20_10g_cksum_time.out &
		#Transfer the blocks from 2 to 100 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 100M ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_20_10g_time.out 
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e
	 
		wait
	
	done
	
	#Compute the last block checksum of file i
<<<<<<< HEAD
	 (time $GRIDFTP_PATH/globus-url-copy -p 1 -off 9900M -len 100M -sync -sync-level 3 ftp://cc075.fst.alcf.anl.gov:46040/scratch/md5_data/$data10g ftp://cc073.fst.alcf.anl.gov:48099/scratch/checksum_tests/$data10g) &>> pipe_block_xfer_20_10g_cksum_block100M.out  &
	#Transfer the first block of file i+1
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 100M ftp://cc075.fst.alcf.anl.gov:46040/scratch/md5_data/$data10g_next ftp://cc073.fst.alcf.anl.gov:48099/scratch/checksum_tests/$data10g_next) &>> pipe_block_xfer_20_10g_block100M.out
=======
	 (time $GRIDFTP_PATH/globus-url-copy -p 1 -off 9900M -len 100M -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g\_100) &>> pipe_block_xfer_20_10g_cksum_time.out  &
	#Transfer the first block of file i+1
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 100M ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g_next\_1) &>> pipe_block_xfer_20_10g_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

	wait

done

#Deal with the last file, file No. 20
for j in {0..98}
do
	offset=$((100*j))M
<<<<<<< HEAD
	#blockname=10G.data20_$((j+1))
	offset_next=$((100*(j+1)))M
	#blockname_next=10G.data20\_$((j+2))

	#Compute the checksum of blocks from 1 to 99 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 100M -sync -sync-level 3 ftp://cc075.fst.alcf.anl.gov:46040/scratch/md5_data/10G.data20 ftp://cc073.fst.alcf.anl.gov:48099/scratch/checksum_tests/10G.data20) &>> pipe_block_xfer_20_10g_cksum_block100M.out  &
	#Transfer the blocks from 2 to 100 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 100M ftp://cc075.fst.alcf.anl.gov:46040/scratch/md5_data/10G.data20 ftp://cc073.fst.alcf.anl.gov:48099/scratch/checksum_tests/10G.data20) &>> pipe_block_xfer_20_10g_block100M.out 
=======
	blockname=10G.data20_$((j+1))
	offset_next=$((100*(j+1)))M
	blockname_next=10G.data20\_$((j+2))

	#Compute the checksum of blocks from 1 to 99 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 100M -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> pipe_block_xfer_20_10g_cksum_time.out  &
	#Transfer the blocks from 2 to 100 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 100M ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_20_10g_time.out 
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

	wait

done

#Compute the cksum of the last block of the last 10G file
<<<<<<< HEAD
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 9900M -len 100M -sync -sync-level 3 ftp://cc075.fst.alcf.anl.gov:46040/scratch/md5_data/10G.data20 ftp://cc073.fst.alcf.anl.gov:48099/scratch/checksum_tests/10G.data20) &>> pipe_block_xfer_20_10g_cksum_block100M.out
=======
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 9900M -len 100M -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data20_100) &>> pipe_block_xfer_20_10g_cksum_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

wait
