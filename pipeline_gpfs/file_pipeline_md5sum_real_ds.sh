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

xfer_output=file_pipeline_xfer.out
cksum_output=file_pipeline_cksum.out

starttime=`echo $SECONDS`

#file counter, to get the index of the file to process
counter=1

#Transfer the first file, no overlap with others
(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://$SOURCE/$FILE_DIR/$firstfile ftp://$DESTINATION/$RESULT_DIR/) &>> $xfer_output

for file in ${filelist[@]}
do
	#Current filesize
    	filesize_byte=$(stat -c%s "$FILE_DIR/$file")
    	filesize=`expr $filesize_byte / 1024 / 1024`
         
        #Next file
    	counter_next=$(($counter+1))
    	file_next=${filelist[$counter_next]}

	#Compute the cksum of file from 1 to num_file
	(time dd bs=1M skip=0 count=$filesize if=/$FILE_DIR/$file | md5sum)  &>> $cksum_output  &
	
	if [ $counter -lt $num_file ]	
	then
		#Transfer files from 2 to num_file
		(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://$SOURCE/$FILE_DIR/$file_next ftp://$DESTINATION/$RESULT_DIR/) &>> $xfer_output
	fi
	wait
        counter=$(($counter+1))
done

 
wait

endtime=`echo $SECONDS`
timetaken=`expr $endtime - $starttime`

echo "Time taken for real dataset file pipeline is : " $timetaken

