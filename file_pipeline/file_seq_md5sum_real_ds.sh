#! /bin/bash
GRIDFTP_PATH=/home/siliu/gridftp-cooley/bin

SOURCE=cc096.fst.alcf.anl.gov:39561
DESTINATION=cc088.fst.alcf.anl.gov:43884

RESULT_DIR=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests
FILE_DIR=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/real_data

files=`ls $FILE_DIR`
filelist=($files)
num_file=${#filelist[@]}
firstfile=${filelist[0]}

xfer_output=file_seq_xfer.out
cksum_output=file_seq_cksum.out

starttime=`echo $SECONDS`


for file in ${filelist[@]}
do
	#Current filesize
    	filesize_byte=$(stat -c%s "$FILE_DIR/$file")
    	filesize=`expr $filesize_byte / 1024 / 1024`
         

	#Transfer the first file, no overlap with others
	(time $GRIDFTP_PATH/globus-url-copy -p 1 ftp://$SOURCE/$FILE_DIR/$file ftp://$DESTINATION/$RESULT_DIR/) &>> $xfer_output
	
	#Compute the cksum of file from 1 to num_file
	(time dd bs=1M skip=0 count=$filesize if=/$FILE_DIR/$file | md5sum)  &>> $cksum_output
	
done

endtime=`echo $SECONDS`
timetaken=`expr $endtime - $starttime`

echo "Time taken for real dataset file sequential is : " $timetaken

