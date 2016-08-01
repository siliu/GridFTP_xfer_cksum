#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

for i in {1..20}
do

	(time $GRIDFTP_PATH/globus-url-copy  ftp://cc091.fst.alcf.anl.gov:46836/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/500M.data ftp://cc055.fst.alcf.anl.gov:38113/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> xfer_500M_10G.out

done


	(time $GRIDFTP_PATH/globus-url-copy  ftp://cc091.fst.alcf.anl.gov:46836/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data ftp://cc055.fst.alcf.anl.gov:38113/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> xfer_500M_10G.out
