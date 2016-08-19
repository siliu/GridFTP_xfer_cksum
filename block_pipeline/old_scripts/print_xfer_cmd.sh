#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first block in the first 10G file, no overlap with others
#$GRIDFTP_PATH/globus-url-copy -off 0 -len 500M ftp://cc102.fst.alcf.anl.gov:36406/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc103.fst.alcf.anl.gov:46063/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data1_1

#Deal with blocks in 10G files from 1 to 9,  and 10M files from 1 to 9
for i in {1..2}
do
	data10g=10G.data$i
	data10m=10M.data$i
	data10g_next=10G.data$((i+1))

	#10G data
	for j in {0..5}
	do 
		echo $j
		offset=$((500*j))M
		blockname=$data10g\_$((j+1))
		offset_next=$((500*(j+1)))M
                blockname_next=$data10g\_$((j+2))

		#Compute the checksum of blocks from 1 to 19 of file i
		cmd="$GRIDFTP_PATH/globus-url-copy -off $offset -len 500M -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:36406/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc103.fst.alcf.anl.gov:46063/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname"
		echo $cmd
		#Transfer the blocks from 2 to 20 of file i
		#$GRIDFTP_PATH/globus-url-copy -off $offset_next -len 500M ftp://cc102.fst.alcf.anl.gov:36406/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc103.fst.alcf.anl.gov:46063/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next


	done

	#Compute the last block checksum of file i
	#$GRIDFTP_PATH/globus-url-copy -off 9500M -len 500M -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:36406/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc103.fst.alcf.anl.gov:46063/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g\_20 &	
	#Transfer the ith 10M file
	#$GRIDFTP_PATH/globus-url-copy ftp://cc102.fst.alcf.anl.gov:36406/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc103.fst.alcf.anl.gov:46063/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/


	#Compute the checksum of the ith 10M file
	#$GRIDFTP_PATH/globus-url-copy -sync -sync-level 3 ftp://cc102.fst.alcf.anl.gov:36406/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc103.fst.alcf.anl.gov:46063/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10m &
	
	#Transfer the first block of the  (i+1)th 10G file
	#$GRIDFTP_PATH/globus-url-copy -off 0 -len 500M ftp://cc102.fst.alcf.anl.gov:36406/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc103.fst.alcf.anl.gov:46063/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g_next\_1

	#wait
done

#Deal with the last 10G file, file No 10
