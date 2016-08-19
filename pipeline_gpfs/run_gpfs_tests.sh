#! /bin/bash

#Experiments with 2 cksum threads 

DIRECTORY=/home/siliu/cksum_scripts/pipeline_gpfs

#Real dataset
#for i in {1..5}
#do
#        echo "Real Dataset  Run-$i: " &>> run_gpfs_tests.out        
#
#	echo "********************Real dataset block pipeline on GPFS********************" >> run_gpfs_tests.out
#	$DIRECTORY/block_pipeline_md5sum_real_ds_v2.sh &>> run_gpfs_tests.out
#
#	echo "********************Real dataset file pipeline on GPFS********************" >> run_gpfs_tests.out
#	$DIRECTORY/file_pipeline_md5sum_real_ds.sh &>> run_gpfs_tests.out
#	
#	echo "********************Real dataset file sequential on GPFS********************" >> run_gpfs_tests.out
#	$DIRECTORY/file_seq_md5sum_real_ds.sh &>> run_gpfs_tests.out
#done

#Dataset with 10G-500M files
#for i in {1..5}
#do
#        echo "Dataset 10G-500M Run-$i: " &>> run_gpfs_tests.out        
#
#	echo "********************10G 500M dataset block pipeline on GPFS********************" >> run_gpfs_tests.out
#	$DIRECTORY/block_pipeline_md5sum_10G_500M_v2.sh &>> run_gpfs_tests.out
#
#	echo "********************10G 500M dataset file pipeline on GPFS********************" >> run_gpfs_tests.out
#	$DIRECTORY/file_pipeline_md5sum_10G_500M.sh &>> run_gpfs_tests.out
#	
#	echo "********************10G 500M dataset file sequential on GPFS********************" >> run_gpfs_tests.out
#	$DIRECTORY/seq_xfer_cksum_10G_500M_md5sum.sh &>> run_gpfs_tests.out
#done
	
#Dataset with 20-10G files
for i in {1..5}
do
        echo "Dataset 20-10G Run-$i: " &>> run_gpfs_tests.out        
	
	echo "********************20 10G dataset block pipeline on GPFS********************" >> run_gpfs_tests.out
	$DIRECTORY/block_pipeline_md5sum_20_10G_v2.sh &>> run_gpfs_tests.out

	echo "********************20 10G dataset file pipeline on GPFS********************" >> run_gpfs_tests.out
	$DIRECTORY/file_pipeline_md5sum_20_10G.sh &>> run_gpfs_tests.out
	
	echo "********************20 10G dataset file sequential on GPFS********************" >> run_gpfs_tests.out
	$DIRECTORY/seq_xfer_cksum_20_10G_md5sum.sh &>> run_gpfs_tests.out
done
