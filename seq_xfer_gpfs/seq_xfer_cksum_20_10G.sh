#! /bin/bash
GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

starttime=`echo $SECONDS`

for i in {1..20}
do
	data10g=10G.data$i

	#Transfer the 10G file from 1 to 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc081.fst.alcf.anl.gov:33806/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc020.fst.alcf.anl.gov:53055/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> seq_xfer_20_10g_each_time.out
	
	#Compute the cksum of 10G file from 1 to 19
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc081.fst.alcf.anl.gov:33806/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc020.fst.alcf.anl.gov:53055/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g) &>>seq_xfer_20_10g_cksum_each_time.out  

done

sync

ssh cc020 "sync"

endtime=`echo $SECONDS`
timetaken=`expr $endtime - $starttime`
echo "Time taken for 20-10G dataset sequential data transfer on GPFS is : " $timetaken
