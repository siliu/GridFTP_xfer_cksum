#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#blocklist=(1000 2000)
blocklist=(100 500 1000 2000)

for block in ${blocklist[@]}
do
  blockdata=$(($block))M.data
  blocknum=`expr 10000 / $block - 1`
  xfer_output=pipe_block_xfer_20_10g_block$(($block))M.out
  cksum_output=pipe_block_xfer_20_10g_cksum_block$(($block))M.out

  starttime=`echo $SECONDS`

  #Transfer the first block in the first file, no overlap with others
  (time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len $(($block))M ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/10G.data1 ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/10G.data1) &>> $xfer_output

  #Deal with files from 1 to 19
  for i in {1..19}
  do
    data10g=10G.data$i
    data10g_next=10G.data$((i+1))

    #Deal with each block
    for j in $( seq $blocknum)
    do
      offset=$(($block*$j))M

      #Compute the checksum of blocks from 1 to 4 of file i
      (time $GRIDFTP_PATH/globus-url-copy -p 1 -sync  -sync-level 3 ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/$blockdata ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/$blockdata)  &>> $cksum_output &

      #Transfer the blocks from 2 to 5 of file i
      (time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len $(($block))M ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/$data10g ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/$data10g) &>> $xfer_output

      wait

    done

    #Compute the last block checksum of file i
    (time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/$blockdata ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/$blockdata) &>> $cksum_output  &

    #Transfer the first block of file i+1
    (time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len $(($block))M ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/$data10g_next ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/$data10g_next) &>> $xfer_output

    wait

  done

  #Deal with the last file, file No. 20
  for j in $( seq $blocknum)
  do

    offset=$(($block*$j))M

    #Compute the checksum of blocks from 1 to 4 of file No. 20
    (time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/$blockdata ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/$blockdata) &>> $cksum_output  &

    #Transfer the blocks from 2 to 5 of file No. 20
    (time $GRIDFTP_PATH/globus-url-copy -p 1 -off $offset -len $(($block))M ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/10G.data20 ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/10G.data20) &>> $xfer_output

    wait

  done

  #Compute the cksum of the last block of the last 10G file
  (time $GRIDFTP_PATH/globus-url-copy -p 1 -sync -sync-level 3 ftp://cc048.fst.alcf.anl.gov:42858/scratch/md5_data/$blockdata ftp://cc059.fst.alcf.anl.gov:37205/scratch/checksum_tests/$blockdata) &>> $cksum_output

  wait
  
  sync
  ssh cc059 "sync"
  
  endtime=`echo $SECONDS`
  timetaken=`expr $endtime - $starttime`
  echo "Time taken for $block block pipeline is : " $timetaken
done

