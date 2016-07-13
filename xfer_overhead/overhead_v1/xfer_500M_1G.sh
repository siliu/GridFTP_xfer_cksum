#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

for i in {1..10}
do
	echo "No: " $i >> xfer_500M_1G.out

	(time $GRIDFTP_PATH/globus-url-copy  ftp://cc040.fst.alcf.anl.gov:60380/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/500M.data ftp://cc118.fst.alcf.anl.gov:54143/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> xfer_500M_1G.out

	(time $GRIDFTP_PATH/globus-url-copy  ftp://cc040.fst.alcf.anl.gov:60380/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/1G.data ftp://cc118.fst.alcf.anl.gov:54143/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> xfer_500M_1G.out

done
