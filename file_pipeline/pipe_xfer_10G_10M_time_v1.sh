#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first file, no overlap with others 
(time $GRIDFTP_PATH/globus-url-copy ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_10g_time.out

for i in {1..9}
do
	data10g=10G.data$i
	data10m=10M.data$i
	data10g_next=10G.data$((i+1))

	#Compute cksum of 10G file from 1 to 9
	(time $GRIDFTP_PATH/globus-url-copy -sync -sync-level 3 ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g) &>>pipe_xfer_10g_cksum_time.out  &
	#Transfer 10M file from 1 to 9
	(time $GRIDFTP_PATH/globus-url-copy  ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_10m_time.out
	wait 

	#Compute cksum of 10M file from 1 to 9
	(time $GRIDFTP_PATH/globus-url-copy -sync -sync-level 3 ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10m) &>>pipe_xfer_10m_cksum_time.out  &
	#Transfer 10G file from 2 to 10
	(time $GRIDFTP_PATH/globus-url-copy ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_10g_time.out
	wait
done

# Compute the checksum of the last 10G file
(time $GRIDFTP_PATH/globus-url-copy -sync -sync-level 3 ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data10) &>> pipe_xfer_10g_cksum_time.out &
#Transfer the last 10M file 
(time $GRIDFTP_PATH/globus-url-copy  ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10M.data10 ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_10m_time.out
wait

# Compute the checksum of the last file, no overlap with others
(time $GRIDFTP_PATH/globus-url-copy -sync -sync-level 3 ftp://cc064.fst.alcf.anl.gov:59552/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10M.data10 ftp://cc102.fst.alcf.anl.gov:56083/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10M.data10) &>> pipe_xfer_10m_cksum_time.out

wait
