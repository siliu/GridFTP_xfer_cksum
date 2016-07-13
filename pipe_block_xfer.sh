#! /bin/bash

for i in {1..10}
do
	data10g=10G.data$i
	data10m=10M.data$i

	#10G data
	for j in {0..99}
	do 
		offsite=$((100*j))M
		blockname=$data10g\_$((j+1))
		#echo $blockname
		globus-url-copy -vb -off $offsite -len 100M ftp://miralac1.fst.alcf.anl.gov:50868/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cetuslac1.fst.alcf.anl.gov:40434/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname
		globus-url-copy -vb -off $offsite -len 100M -sync -sync-level 3 ftp://miralac1.fst.alcf.anl.gov:50868/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10g ftp://cetuslac1.fst.alcf.anl.gov:40434/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$blockname &
	done

	#10M data
	globus-url-copy -vb  ftp://miralac1.fst.alcf.anl.gov:50868/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cetuslac1.fst.alcf.anl.gov:40434/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/
	globus-url-copy -vb -sync -sync-level 3 ftp://miralac1.fst.alcf.anl.gov:50868/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/$data10m ftp://cetuslac1.fst.alcf.anl.gov:40434/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/$data10m &

done
