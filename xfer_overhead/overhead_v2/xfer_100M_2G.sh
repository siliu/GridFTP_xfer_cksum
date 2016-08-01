#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

for i in {1..20}
do

	(time $GRIDFTP_PATH/globus-url-copy  ftp://cc040.fst.alcf.anl.gov:60380/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/100M.data ftp://cc118.fst.alcf.anl.gov:54143/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> xfer_100M_2G.out


done

	(time $GRIDFTP_PATH/globus-url-copy  ftp://cc040.fst.alcf.anl.gov:60380/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/2G.data ftp://cc118.fst.alcf.anl.gov:54143/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> xfer_100M_2G.out
