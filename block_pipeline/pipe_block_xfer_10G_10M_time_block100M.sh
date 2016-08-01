#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first block in the first 10G file, no overlap with others
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 100M ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data1_1) &>> pipe_block_xfer_10g_block100M.out

#Deal with blocks in 10G files from 1 to 9,  and 10M files from 1 to 9
for i in {1..9}
do
	data10g=10G.data$i
	data10m=10M.data$i
	data10g_next=10G.data$((i+1))

	#10G data
	for j in {0..98}
	do 
		offset=$((100*j))M
		blockname=$data10g\_$((j+1))
		offset_next=$((100*(j+1)))M
                blockname_next=$data10g\_$((j+2))

		#Compute the checksum of blocks from 1 to 99 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 100M -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> pipe_block_xfer_10g_cksum_block100M.out &
		#Transfer the blocks from 2 to 100 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 100M ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_10g_block100M.out

		wait

	done

	#Compute the last block checksum of file i
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 9900M -len 100M -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g\_100) &>> pipe_block_xfer_10g_cksum_block100M.out  &	
	#Transfer the ith 10M file
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_block_xfer_10m_block100M.out

	wait

	#Compute the checksum of the ith 10M file
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10m) &>> pipe_block_xfer_10m_cksum_block100M.out &
	
	#Transfer the first block of the  (i+1)th 10G file
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 100M ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g_next\_1) &>> pipe_block_xfer_10g_block100M.out 

	wait
done

#Deal with the last 10G file, file No 10
for j in {0..98}
do
	offset=$((100*j))M
	blockname=10G.data10\_$((j+1))
	offset_next=$((100*(j+1)))M
	blockname_next=10G.data10\_$((j+2))

	#Compute the checksum of blocks from 1 to 99 of file 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len 100M -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname) &>> pipe_block_xfer_10g_cksum_block100M.out &
	#Transfer the blocks from 2 to 100 of file 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 100M ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_10g_block100M.out

	wait

done

#Compute the checksum of the last block of file 10
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 9900M -len 100M -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data10_100) &>> pipe_block_xfer_10g_cksum_block100M.out &

#Tansfer the last 10M file
(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10M.data10 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_block_xfer_10m_block100M.out

wait

#Compute the checksum of the last 10M file, it does not need to go background
(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:51152/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10M.data10 ftp://cc026.fst.alcf.anl.gov:59720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10M.data10) &>> pipe_block_xfer_10m_cksum_block100M.out

wait
