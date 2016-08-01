#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

for i in {1..10}
do

	(time $GRIDFTP_PATH/globus-url-copy  ftp://cc091.fst.alcf.anl.gov:46836/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/2G.data ftp://cc055.fst.alcf.anl.gov:38113/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> xfer_2G_20G.out

done


	(time $GRIDFTP_PATH/globus-url-copy  ftp://cc091.fst.alcf.anl.gov:46836/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/20G.data ftp://cc055.fst.alcf.anl.gov:38113/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> xfer_2G_20G.out
