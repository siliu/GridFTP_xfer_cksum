#! /bin/bash

GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

SOURCE=cc018.fst.alcf.anl.gov:58897
DESTINATION=cc005.fst.alcf.anl.gov:35955

RESULT_DIR=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests
FILE_DIR=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/real_data

files=`ls $FILE_DIR`
filelist=($files)
num_file=${#filelist[@]}
firstfile=${filelist[0]}

blocklist=(50 100 500 1000)
#blocklist=(1000)

for block in ${blocklist[@]}
do

  halfblock=`expr $block / 2`   
  
  #Transfer and checksum logs
  xfer_output=block_pipeline_xfer_block$(($block))M.out
  cksum_output=block_pipeline_cksum_block$(($block))M.out
  
  #file counter, to get the index of the file to process
  counter=0
  
  #Time to start
  starttime=`echo $SECONDS`

  # Transfer the first block in the first file, no overlap with others
   firstfile=${filelist[0]}

   firstfilesize_byte=$(stat -c%s "$FILE_DIR/$firstfile")
   firstfilesize=`expr $firstfilesize_byte / 1024 / 1024`
   firstblock=$block

   if [ $firstfilesize -lt $block ]
   then
       firstblock=$firstfilesize
   fi
 
  (time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len $(($firstblock))M ftp://$SOURCE/$FILE_DIR/$firstfile ftp://$DESTINATION/$RESULT_DIR/$firstfile) &>> $xfer_output
  
#Transfer files in the file directory
  for file in ${filelist[@]}
  do
    #Current filesize
    filesize_byte=$(stat -c%s "$FILE_DIR/$file")
    filesize=`expr $filesize_byte / 1024 / 1024`
  
    blocknum=`expr $filesize / $block`
    lastblock=`expr $filesize % $block`
    halflastblock=`expr $lastblock / 2`
    
    #If file size is larger than block size, pipeline each block in the file
    if [ $filesize -lt $block ]
    then	
	blocknum=1
	lastblock=$filesize
    fi

    #Next file
    counter_next=$(($counter+1))
    file_next=${filelist[$counter_next]}
    filesize_next_byte=$(stat -c%s "$FILE_DIR/$file_next")
    filesize_next=`expr $filesize_next_byte / 1024 / 1024`
    firstblock_next=$block
    
    #The transfer of first block of the next file is pipelined with the checksum of the last block of the current file 
    if [ $filesize_next -lt $block ]
    then
        firstblock_next=$filesize_next
    fi
        
    #Deal with checksum and transfer pipeline
    for ((j=0; j<=$(($blocknum-1)); j++))
    do
      	offset=$(($block*$j))
     	offset_next=$(($block*($j+1)))

      	#Compute the checksum of blocks from 1 to blocknum-1 of the current file
    	if [ $filesize -ge $block ]
    	then	
    		(time dd bs=1M skip=$offset count=$halfblock if=/$FILE_DIR/$file | md5sum)  &>> $cksum_output &
		(time dd bs=1M skip=$(($offset+$halfblock)) count=$halfblock if=/$FILE_DIR/$file | md5sum)  &>> $cksum_output &

	      	#Transfer the blocks from 2 to blocknum of the file
       		if [ $j -lt $(($blocknum-1)) ] 
       		then
      			(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $((offset_next))M -len $(($block))M ftp://$SOURCE/$FILE_DIR/$file ftp://$DESTINATION/$RESULT_DIR/$file) &>> $xfer_output
       		else
      			(time $GRIDFTP_PATH/globus-url-copy -p 1 -off $((offset_next))M -len $(($lastblock))M ftp://$SOURCE/$FILE_DIR/$file ftp://$DESTINATION/$RESULT_DIR/$file) &>> $xfer_output
       		fi

       		wait
       fi

    done
    
    #Compute the last block checksum of the current file
    if [ $filesize -ge $block ]
    then	
    	(time dd bs=1M skip=$offset_next count=$halflastblock if=/$FILE_DIR/$file | md5sum)  &>> $cksum_output &
        (time dd bs=1M skip=$(($offset_next+$halflastblock)) count=$halflastblock if=/$FILE_DIR/$file | md5sum)  &>> $cksum_output &
    else
	(time dd bs=1M skip=0 count=$halflastblock if=/$FILE_DIR/$file | md5sum)  &>> $cksum_output &
        (time dd bs=1M skip=$halflastblock count=$halflastblock if=/$FILE_DIR/$file | md5sum)  &>> $cksum_output &
    fi

    #The last block of the last file is not pipelined with any others.
    if [ $counter -lt $(($num_file-1)) ]
    then	
    	#The last block of the current file's checksum is pipelined with the transfer of next file's first block; 
    	(time $GRIDFTP_PATH/globus-url-copy -p 1 -off 0 -len $(($firstblock_next))M ftp://$SOURCE/$FILE_DIR/$file_next ftp://$DESTINATION/$RESULT_DIR/$file_next) &>> $xfer_output
    fi 
    wait

    counter=$(($counter+1))

  done
  
  #The end time of block pipeline for one blocksize
  endtime=`echo $SECONDS`

  #The time taken for block pipeline
  timetaken=`expr $endtime - $starttime`
  echo "Time taken for $block block pipeline is : " $timetaken

done

