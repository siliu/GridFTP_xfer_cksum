#! /bin/bash
GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

starttime=`echo $SECONDS`

for i in {1..10}
do
	data10g=10G.data$i
	data500m=500M.data$i

	#Transfer the 10G file from 1 to 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc081.fst.alcf.anl.gov:33806/scratch/md5_data/$data10g ftp://cc020.fst.alcf.anl.gov:53055/scratch/checksum_tests/) &>> seq_xfer_10g_each_time_md5sum.out
	
	#Compute the cksum of 10G file from 1 to 10
	(time dd bs=1M skip=0 count=10000 if=/scratch/md5_data/$data10g | md5sum) &>> seq_xfer_10g_cksum_each_time_md5sum.out

	#Transfer the 500M file from 1 to 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc081.fst.alcf.anl.gov:33806/scratch/md5_data/$data500m ftp://cc020.fst.alcf.anl.gov:53055/scratch/checksum_tests/) &>> seq_xfer_500m_each_time_md5sum.out
	
	#Compute the cksum of 500M file from 1 to 10
	(time dd bs=1M skip=0 count=500 if=/scratch/md5_data/$data500m | md5sum)  &>>seq_xfer_500m_cksum_each_time_md5sum.out

done

sync

ssh cc020 "sync"

endtime=`echo $SECONDS`

timetaken=`expr $endtime - $starttime`

echo "Time taken for 10G-500m dataset sequential data transfer is : " $timetaken
