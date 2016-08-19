#! /bin/bash

DIRECTORY=/home/siliu/cksum_scripts/block_pipeline
FILE_DIR=/home/siliu/cksum_scripts/file_pipeline

#Dataset with 20 10G files
for i in {1..3}
do
        echo "Run-$i: "        

	echo "********************real data dataset block pipeline on GPFS********************" >> run_tests.out
	$DIRECTORY/block_pipeline_md5sum_real_ds.sh &>> run_tests.out

	echo "********************real data dataset file pipeline on GPFS********************" >> run_tests.out
	$FILE_DIR/file_pipeline_md5sum_real_ds.sh &>> run_tests.out
	
	echo "********************real data dataset file sequential on GPFS********************" >> run_tests.out
	$FILE_DIR/file_seq_md5sum_real_ds.sh &>> run_tests.out
done
