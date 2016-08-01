#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first block in the first file, no overlap with others
$GRIDFTP_PATH/globus-url-copy -off 0 -len 500M ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data1_1

#Deal with files from 1 to 19
for i in {1..19}
do
	data10g=10G.data$i
	data10g_next=10G.data$((i+1))

	#10G data
	for j in {0..18}
	do 
		offset=$((500*j))M
		blockname=$data10g\_$((j+1))
		offset_next=$((500*(j+1)))M
		blockname_next=$data10g\_$((j+2))
	        # globus-url-copy -off $offset -len 500M ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname
		
		#Compute the checksum of blocks from 1 to 19 of file i	
		$GRIDFTP_PATH/globus-url-copy -off $offset -len 500M -sync -sync-level 3 ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname &
		#Transfer the blocks from 2 to 20 of file i
		$GRIDFTP_PATH/globus-url-copy -off $offset_next -len 500M ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next
	
		wait
	
	done
	
	#Compute the last block checksum of file i
	 $GRIDFTP_PATH/globus-url-copy -off 9500M -len 500M -sync -sync-level 3 ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g\_20 &
	#Transfer the first block of file i+1
	$GRIDFTP_PATH/globus-url-copy -off 0 -len 500M ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g_next\_1

	wait

done

#Deal with the last file, file No. 20
for j in {0..18}
do
	offset=$((500*j))M
	blockname=10G.data20_$((j+1))
	offset_next=$((500*(j+1)))M
	blockname_next=10G.data20\_$((j+2))

	#Compute the checksum of blocks from 1 to 19 of file No. 20
	$GRIDFTP_PATH/globus-url-copy -off $offset -len 500M -sync -sync-level 3 ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname &
	#Transfer the blocks from 2 to 20 of file No. 20
	$GRIDFTP_PATH/globus-url-copy -off $offset_next -len 500M ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname_next

	wait

done

#Compute the cksum of the last block of the last 10G file
$GRIDFTP_PATH/globus-url-copy -off 9500M -len 500M -sync -sync-level 3 ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data20_20

wait
