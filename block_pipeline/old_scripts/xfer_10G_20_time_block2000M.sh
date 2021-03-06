#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first block in the first file, no overlap with others
(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 2000M ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data1_1) &>> pipe_block_xfer_20_10g_time.out

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

		#Transfer the blocks from 2 to 5 of file i
		(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 2000M ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_20_10g_time.out 
	
	done
	
	#Transfer the first block of file i+1
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len 2000M ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g_next\_1) &>> pipe_block_xfer_20_10g_time.out

	wait

done

#Deal with the last file, file No. 20
for j in {0..3}
do
	offset=$((2000*j))M
	blockname=10G.data20_$((j+1))
	offset_next=$((2000*(j+1)))M
	blockname_next=10G.data20\_$((j+2))

	#Transfer the blocks from 2 to 5 of file No. 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset_next -len 2000M ftp://cc078.fst.alcf.anl.gov:56501/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc055.fst.alcf.anl.gov:47169/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next) &>> pipe_block_xfer_20_10g_time.out 


done

