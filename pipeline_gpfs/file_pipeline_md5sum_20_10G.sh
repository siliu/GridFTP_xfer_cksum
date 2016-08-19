#! /bin/bash
GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

starttime=`echo $SECONDS`

#Transfer the first file, no overlap with others
(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc041.fst.alcf.anl.gov:45153/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc095.fst.alcf.anl.gov:42650/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> file_pipeline_md5sum_20_10g_xfer_time.out

for i in {1..19}
do
	data10g=10G.data$i
	data10g_next=10G.data$((i+1))

	#Compute the cksum of 10G file from 1 to 19
	#(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc041.fst.alcf.anl.gov:45153/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc095.fst.alcf.anl.gov:42650/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g) &>>file_pipeline_md5sum_20_10g_cksum_time.out  &
	(time dd bs=1M skip=0 count=10000 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g | md5sum)  &>> file_pipeline_md5sum_20_10g_cksum_time.out  &
	
	#Transfer the 10G file from 2 to 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc041.fst.alcf.anl.gov:45153/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc095.fst.alcf.anl.gov:42650/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> file_pipeline_md5sum_20_10g_xfer_time.out

	wait

done

#Compute the cksum of the last 10G file
#(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc041.fst.alcf.anl.gov:45153/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 ftp://cc095.fst.alcf.anl.gov:42650/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data20) &>> file_pipeline_md5sum_20_10g_cksum_time.out
(time dd bs=1M skip=0 count=10000 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data20 | md5sum)  &>> file_pipeline_md5sum_20_10g_cksum_time.out
 
wait


endtime=`echo $SECONDS`
timetaken=`expr $endtime - $starttime`
echo "Time taken for 20 10G dataset file pipeline is : " $timetaken
