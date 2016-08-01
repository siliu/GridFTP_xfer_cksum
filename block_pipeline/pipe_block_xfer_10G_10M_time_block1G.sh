#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first block in the first 10G file, no overlap with others
<<<<<<< HEAD
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 1000M ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data1_1) &>> pipe_block_xfer_10g_block1G.out
=======
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 1G ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data1_1) &>> pipe_block_xfer_10g_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

#Deal with blocks in 10G files from 1 to 9,  and 10M files from 1 to 9
for i in {1..9}
do
	data10g=10G.data$i
	data10m=10M.data$i
	data10g_next=10G.data$((i+1))

	#10G data
	for j in {0..8}
	do 
<<<<<<< HEAD
		offset=$((1000*j))M
		blockname=$data10g\_$((j+1))
		offset_next=$((1000*(j+1)))M
                blockname_next=$data10g\_$((j+2))

		#Compute the checksum of blocks from 1 to 9 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 1000M -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> pipe_block_xfer_10g_cksum_block1G.out &
		#Transfer the blocks from 2 to 10 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 1000M ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_10g_block1G.out
=======
		offset=$((1*j))G
		blockname=$data10g\_$((j+1))
		offset_next=$((1*(j+1)))G
                blockname_next=$data10g\_$((j+2))

		#Compute the checksum of blocks from 1 to 9 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 1G -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> pipe_block_xfer_10g_cksum_time.out &
		#Transfer the blocks from 2 to 10 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 1G ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_10g_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

		wait

	done

	#Compute the last block checksum of file i
<<<<<<< HEAD
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 9000M -len 1000M -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g\_10) &>> pipe_block_xfer_10g_cksum_block1G.out  &	
	#Transfer the ith 10M file
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_block_xfer_10m_block1G.out
=======
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 9000M -len 1G -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g\_10) &>> pipe_block_xfer_10g_cksum_time.out  &	
	#Transfer the ith 10M file
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_block_xfer_10m_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

	wait

	#Compute the checksum of the ith 10M file
<<<<<<< HEAD
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10m) &>> pipe_block_xfer_10m_cksum_block1G.out &
	
	#Transfer the first block of the  (i+1)th 10G file
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 1000M ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g_next\_1) &>> pipe_block_xfer_10g_block1G.out 
=======
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10m) &>> pipe_block_xfer_10m_cksum_time.out &
	
	#Transfer the first block of the  (i+1)th 10G file
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 1G ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g_next\_1) &>> pipe_block_xfer_10g_time.out 
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

	wait
done

#Deal with the last 10G file, file No 10
for j in {0..8}
do
<<<<<<< HEAD
	offset=$((1000*j))M
	blockname=10G.data10\_$((j+1))
	offset_next=$((1000*(j+1)))M
	blockname_next=10G.data10\_$((j+2))

	#Compute the checksum of blocks from 1 to 9 of file 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 1000M -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> pipe_block_xfer_10g_cksum_block1G.out &
	#Transfer the blocks from 2 to 10 of file 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 1000M ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_10g_block1G.out
=======
	offset=$((1*j))G
	blockname=10G.data10\_$((j+1))
	offset_next=$((1*(j+1)))G
	blockname_next=10G.data10\_$((j+2))

	#Compute the checksum of blocks from 1 to 9 of file 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 1G -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> pipe_block_xfer_10g_cksum_time.out &
	#Transfer the blocks from 2 to 10 of file 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 1G ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_10g_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

	wait

done

#Compute the checksum of the last block of file 10
<<<<<<< HEAD
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 9000M -len 1000M -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data10_10) &>> pipe_block_xfer_10g_cksum_block1G.out &

#Tansfer the last 10M file
(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10M.data10 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_block_xfer_10m_block1G.out
=======
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 9000M -len 1G -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data10_10) &>> pipe_block_xfer_10g_cksum_time.out &

#Tansfer the last 10M file
(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10M.data10 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_block_xfer_10m_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

wait

#Compute the checksum of the last 10M file, it does not need to go background
<<<<<<< HEAD
(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10M.data10 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10M.data10) &>> pipe_block_xfer_10m_cksum_block1G.out
=======
(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10M.data10 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10M.data10) &>> pipe_block_xfer_10m_cksum_time.out
>>>>>>> 269985369bb632cc44a66cc0d766f0ffca390d8e

wait
