#! /bin/bash
GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first file, no overlap with others
(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_20_10g_time.out

for i in {1..19}
do
	data10g=10G.data$i
	data10g_next=10G.data$((i+1))

	#Compute the cksum of 10G file from 1 to 19
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g) &>>pipe_xfer_20_10g_cksum_time.out  &
	#Transfer the 10G file from 2 to 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_20_10g_time.out
	wait

done

#Compute the cksum of the last 10G file
(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc043.fst.alcf.anl.gov:36720/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc065.fst.alcf.anl.gov:60044/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data20/) &>> pipe_xfer_20_10g_cksum_time.out

wait
