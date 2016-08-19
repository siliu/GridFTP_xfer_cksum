#! /bin/bash
GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

starttime=`echo $SECONDS`

for i in {1..10}
do
	data10g=10G.data$i
	data500m=500M.data$i

	#Transfer the 10G file from 1 to 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc018.fst.alcf.anl.gov:58897/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc005.fst.alcf.anl.gov:35955/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> seq_xfer_10g_each_time_md5sum.out
	
	#Compute the cksum of 10G file from 1 to 10
	(time dd bs=1M skip=0 count=10000 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g | md5sum) &>> seq_xfer_10g_cksum_each_time_md5sum.out

	#Transfer the 500M file from 1 to 10
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc018.fst.alcf.anl.gov:58897/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data500m ftp://cc005.fst.alcf.anl.gov:35955/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> seq_xfer_500m_each_time_md5sum.out
	
	#Compute the cksum of 500M file from 1 to 10
	(time dd bs=1M skip=0 count=500 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data500m | md5sum)  &>>seq_xfer_500m_cksum_each_time_md5sum.out

done


endtime=`echo $SECONDS`

timetaken=`expr $endtime - $starttime`

echo "Time taken for 10G-500m dataset sequential data transfer with md5sum on GPFS is : " $timetaken
