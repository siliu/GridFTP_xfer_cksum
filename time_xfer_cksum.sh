#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#blocklist=(1000 2000)
filelist=("100M.data" "500M.data" "1000M.data" "2000M.data" "5G.data" "10G.data")

for file in ${filelist[@]}
do
  echo $file
  xfer_starttime=`echo $SECONDS`

  #Transfer the first block in the first file, no overlap with others
  $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc009.fst.alcf.anl.gov:47151/scratch/md5_data/$file ftp://cc017.fst.alcf.anl.gov:51001/scratch/checksum_tests/
 
  sync
  ssh cc017 "sync"

  xfer_endtime=`echo $SECONDS`

  xfer_time=`expr $xfer_endtime - $xfer_starttime`

  echo "Time taken for tranferring file $file is : " $xfer_time

  cksum_starttime=`echo $SECONDS` 
  $GRIDFTP_PATH/globus-url-copy -p 1 -sync  -sync-level 3 ftp://cc009.fst.alcf.anl.gov:47151/scratch/md5_data/$file ftp://cc017.fst.alcf.anl.gov:51001/scratch/checksum_tests/$file
  
  cksum_endtime=`echo $SECONDS`
  
  cksum_time=`expr $cksum_endtime - $cksum_starttime`
  echo "Time taken for computing checksum for file $file is : " $cksum_time
done

