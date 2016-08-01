#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

starttime=`echo $SECONDS`

#Transfer the first file, no overlap with others 
(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc031.fst.alcf.anl.gov:58558/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc033.fst.alcf.anl.gov:60887/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_10g_time.out

for i in {1..9}
do
	data10g=10G.data$i
	data500m=500M.data$i
	data10g_next=10G.data$((i+1))

	#Compute cksum of 10G file from 1 to 9
	#(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc031.fst.alcf.anl.gov:58558/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc033.fst.alcf.anl.gov:60887/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g) &>>pipe_xfer_10g_cksum_time.out  &

        (time dd bs=1M skip=0 count=10000 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g | md5sum)  &>> pipe_xfer_10g_cksum_time.out  &

	#Transfer 500M file from 1 to 9
	(time $GRIDFTP_PATH/globus-url-copy -p 1  ftp://cc031.fst.alcf.anl.gov:58558/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data500m ftp://cc033.fst.alcf.anl.gov:60887/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_500m_time.out
	wait 

	#Compute cksum of 500M file from 1 to 9
	#(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc031.fst.alcf.anl.gov:58558/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data500m ftp://cc033.fst.alcf.anl.gov:60887/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data500m) &>>pipe_xfer_500m_cksum_time.out  &
	(time dd bs=1M skip=0 count=500 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data500m | md5sum)  &>> pipe_xfer_500m_cksum_time.out  &


	#Transfer 10G file from 2 to 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc031.fst.alcf.anl.gov:58558/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc033.fst.alcf.anl.gov:60887/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_10g_time.out
	wait
done

# Compute the checksum of the last 10G file
#(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc031.fst.alcf.anl.gov:58558/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc033.fst.alcf.anl.gov:60887/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data10) &>> pipe_xfer_10g_cksum_time.out &
(time dd bs=1M skip=0 count=10000 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 | md5sum)  &>> pipe_xfer_10g_cksum_time.out &

#Transfer the last 500M file 
(time $GRIDFTP_PATH/globus-url-copy -p 1  ftp://cc031.fst.alcf.anl.gov:58558/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/500M.data10 ftp://cc033.fst.alcf.anl.gov:60887/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_500m_time.out

wait

# Compute the checksum of the last file, no overlap with others
#(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc031.fst.alcf.anl.gov:58558/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/500M.data10 ftp://cc033.fst.alcf.anl.gov:60887/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/500M.data10) &>> pipe_xfer_500m_cksum_time.out

(time dd bs=1M skip=0 count=500 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/500M.data10 | md5sum)  &>> pipe_xfer_500m_cksum_time.out

wait

sync
ssh cc033 "sync"

endtime=`echo $SECONDS`
timetaken=`expr $endtime - $starttime`

echo "Time taken for 10G-500M dataset file pipeline is : " $timetaken
