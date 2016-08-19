#! /bin/bash
GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#Transfer the first file, no overlap with others
(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/10G.data1 ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/) &>> pipe_xfer_20_10g_time.out

for i in {1..19}
do
	data10g=10G.data$i
	data10g_next=10G.data$((i+1))

	#Compute the cksum of 10G file from 1 to 19
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/$data10g ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/$data10g) &>>pipe_xfer_20_10g_cksum_time.out  &
	#Transfer the 10G file from 2 to 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/$data10g_next ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/) &>> pipe_xfer_20_10g_time.out
	wait

done

#Compute the cksum of the last 10G file
(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/10G.data20 ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/10G.data20) &>> pipe_xfer_20_10g_cksum_time.out

wait

sync

ssh cc059 "sync"
