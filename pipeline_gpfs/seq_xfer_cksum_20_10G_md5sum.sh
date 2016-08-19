#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

starttime=`echo $SECONDS`

for i in {1..20}
do
	data10g=10G.data$i

	#Transfer the 10G file from 1 to 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc041.fst.alcf.anl.gov:45153/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc095.fst.alcf.anl.gov:42650/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> seq_xfer_20_10g_each_time_md5sum.out
	
	#Compute the cksum of 10G file from 1 to 19
	(time dd bs=1M skip=0 count=10000 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g | md5sum) &>> seq_xfer_20_10g_cksum_each_time_md5sum.out
done

endtime=`echo $SECONDS`
timetaken=`expr $endtime - $starttime`

echo "Time taken for 20-10G dataset sequential data transfer is : " $timetaken
