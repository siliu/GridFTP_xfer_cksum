#! /bin/bash

#time the 1st stage
START=$(date +%s)

(time globus-url-copy  ftp://miralac1.fst.alcf.anl.gov:48068/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data1 ftp://cetuslac1.fst.alcf.anl.gov:36518/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>>  pipe_xfer_data10g_time.out 

END=$(date +%s)
DIFF=$(( $END - $START ))
echo "Stage 1 takes $DIFF seconds."

for i in {1..9}
do
	data10g=10G.data$i
	data10m=10M.data$i

	nextdata10g=10G.data$((i+1))
	#time one stage
	START_1=$(date +%s)
	
	(time globus-url-copy -sync -sync-level 3 ftp://miralac1.fst.alcf.anl.gov:48068/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cetuslac1.fst.alcf.anl.gov:36518/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10g) &>> pipe_xfer_data10g_cksum_time.out &
	
	(time globus-url-copy  ftp://miralac1.fst.alcf.anl.gov:48068/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cetuslac1.fst.alcf.anl.gov:36518/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_data10m_time.out
	
	END_1=$(date +%s)
        DIFF_1=$(( $END_1 - $START_1 ))
	echo "1. Stage $i takes $DIFF_1 seconds."

	#time another stage
	START_2=$(date +%s)
	
	(time globus-url-copy -sync -sync-level 3 ftp://miralac1.fst.alcf.anl.gov:48068/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cetuslac1.fst.alcf.anl.gov:36518/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10m) &>> pipe_xfer_data10m_cksum_time.out &
	
	(time globus-url-copy ftp://miralac1.fst.alcf.anl.gov:48068/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$nextdata10g ftp://cetuslac1.fst.alcf.anl.gov:36518/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_data10g_time.out
	
	END_2=$(date +%s)
	DIFF_2=$(( $END_2 - $START_2 ))
	echo "2. Stage $i takes $DIFF_2 seconds."
done

#time 20  stage
START_20=$(date +%s)

(time globus-url-copy -sync -sync-level 3 ftp://miralac1.fst.alcf.anl.gov:48068/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10G.data10 ftp://cetuslac1.fst.alcf.anl.gov:36518/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10G.data10) &>> pipe_xfer_data10g_cksum_time.out &


(time globus-url-copy ftp://miralac1.fst.alcf.anl.gov:48068/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10M.data10 ftp://cetuslac1.fst.alcf.anl.gov:36518/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/) &>> pipe_xfer_data10m_time.out

END_20=$(date +%s)
DIFF_20=$(( $END_20 - $START_20 ))
echo "Stage 20 takes $DIFF_20 seconds."

#time 21  stage
START_21=$(date +%s)
(time globus-url-copy -sync -sync-level 3 ftp://miralac1.fst.alcf.anl.gov:48068/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/10M.data10 ftp://cetuslac1.fst.alcf.anl.gov:36518/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/10M.data10) &>> pipe_xfer_data10m_cksum_time.out 

END_21=$(date +%s)
DIFF_21=$(( $END_21 - $START_21 )) 
echo "Stage 21 takes $DIFF_21 seconds."
