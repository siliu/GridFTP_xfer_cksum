#! /bin/bash
GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

for i in {1..20}
do
	data10g=10G.data$i

	#Transfer the 10G file from 1 to 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc122.fst.alcf.anl.gov:36994/scratch/md5_data/$data10g ftp://cc062.fst.alcf.anl.gov:52651/scratch/checksum_tests/) &>> seq_xfer_20_10g_each_time.out
	
	#Compute the cksum of 10G file from 1 to 19
	(time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc122.fst.alcf.anl.gov:36994/scratch/md5_data/$data10g ftp://cc062.fst.alcf.anl.gov:52651/scratch/checksum_tests/$data10g) &>>seq_xfer_20_10g_cksum_each_time.out  

done

