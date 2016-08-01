#! /bin/bash
GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

for i in {1..20}
do
	data10g=10G.data$i

	#Transfer the 10G file from 1 to 20
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc042.fst.alcf.anl.gov:38992/scratch/md5_data/$data10g ftp://cc044.fst.alcf.anl.gov:51008/scratch/checksum_tests/) &>> xfer_20_10g_each_time.out
	
done

