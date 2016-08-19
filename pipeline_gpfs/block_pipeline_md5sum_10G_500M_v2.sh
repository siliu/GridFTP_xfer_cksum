#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

#blocklist=(1000 2000)
blocklist=(100 500 1000 2000)

for block in ${blocklist[@]}
do
  blocknum=`expr 10000 / $block - 1`
  halfblock=`expr $block / 2`  
  xfer_output_10G=pipe_block_xfer_10G_block$(($block))M.out
  cksum_output_10G=pipe_block_xfer_10G_cksum_block$(($block))M.out
  
  xfer_output_500M=pipe_block_xfer_500M.out
  cksum_output_500M=pipe_block_xfer_500M_cksum.out

  starttime=`echo $SECONDS`

  #Transfer the first block in the first file, no overlap with others
  (time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len $(($block))M ftp://cc018.fst.alcf.anl.gov:58897/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cc005.fst.alcf.anl.gov:35955/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data1) &>> $xfer_output_10G

  #Deal with files from 1 to 19
  for i in {1..9}
  do
    data10g=10G.data$i
    data10g_next=10G.data$((i+1))
    data500m=500M.data$i

    #Deal with each block
    for j in $( seq $blocknum)
    do
      offset=$(($block*($j-1)))
      offset_next=$(($block*$j))

      #Compute the checksum of blocks from 1 to blocksum-1 of file i
      (time dd bs=1M skip=$offset count=$halfblock if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g | md5sum)  &>> $cksum_output_10G &
      (time dd bs=1M skip=$(($offset+$halfblock)) count=$halfblock if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g | md5sum)  &>> $cksum_output_10G &

      #Transfer the blocks from 2 to blocksum of file i
      (time $GRIDFTP_PATH/globus-url-copy -p 1 -off $((offset_next))M -len $(($block))M ftp://cc018.fst.alcf.anl.gov:58897/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cc005.fst.alcf.anl.gov:35955/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g) &>> $xfer_output_10G

      wait

    done

    #Compute the last block checksum of file i
    (time dd bs=1M skip=$offset_next count=$halfblock if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g | md5sum)  &>> $cksum_output_10G &
    (time dd bs=1M skip=$(($offset_next+$halfblock)) count=$halfblock if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g | md5sum)  &>> $cksum_output_10G &

    #Transfer the ith 500M file
    (time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc018.fst.alcf.anl.gov:58897/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data500m ftp://cc005.fst.alcf.anl.gov:35955/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> $xfer_output_500M

    wait

    #Compute the ith 500M file checksum
    (time dd bs=1M skip=0 count=500 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data500m | md5sum)  &>> $cksum_output_500M &
    
    #Transfer the first block of the (i+1)th 10G file
    (time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len $(($block))M ftp://cc018.fst.alcf.anl.gov:58897/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g_next ftp://cc005.fst.alcf.anl.gov:35955/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g_next) &>> $xfer_output_10G

    wait

  done

  #Deal with the last file, file No.10
  for j in $( seq $blocknum)
  do

    offset=$(($block*($j-1)))
    offset_next=$(($block*$j))

    #Compute the checksum of blocks from 1 to blocknum-1 of file No. 10
    (time dd bs=1M skip=$offset count=$halfblock if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 | md5sum)  &>> $cksum_output_10G &
    (time dd bs=1M skip=$(($offset+$halfblock)) count=$halfblock if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 | md5sum)  &>> $cksum_output_10G &

    #Transfer the blocks from 2 to blocknum of file No. 10
    (time $GRIDFTP_PATH/globus-url-copy -p 1 -off $((offset_next))M -len $(($block))M ftp://cc018.fst.alcf.anl.gov:58897/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cc005.fst.alcf.anl.gov:35955/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data10) &>> $xfer_output_10G

    wait

  done

  #Compute the cksum of the last block of the last 10G file
  (time dd bs=1M skip=$offset_next count=$halfblock if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 | md5sum)  &>> $cksum_output_10G &
  (time dd bs=1M skip=$(($offset_next+$halfblock)) count=$halfblock if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 | md5sum)  &>> $cksum_output_10G &
  
  #Transfer the last 500M file 
  (time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://cc018.fst.alcf.anl.gov:58897/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/500M.data10 ftp://cc005.fst.alcf.anl.gov:35955/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> $xfer_output_500M

  wait

  #Compute the checksum of the last 500M file
  (time dd bs=1M skip=0 count=500 if=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/500M.data10 | md5sum)  &>> $cksum_output_500M
  
  
  endtime=`echo $SECONDS`
  timetaken=`expr $endtime - $starttime`
  echo "Time taken for $block block pipeline is : " $timetaken
done

