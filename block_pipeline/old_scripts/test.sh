#! /bin/bash

DIRECTORY=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/cksum_scripts/block_pipeline
RESULTS_DIR=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests
FILE_DIR=/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/cksum_scripts/file_pipeline


#Dataset with 20 10G files
echo "********************pipe_block_xfer_10G_20_time_block100M********************" >> run_tests.out
(time $DIRECTORY/pipe_block_xfer_10G_20_time_block100M.sh) &>> run_tests.out
rm $RESULTS_DIR/*


echo "********************pipe_block_xfer_10G_20_time_block500M********************" >> run_tests.out
(time $DIRECTORY/pipe_block_xfer_10G_20_time_block500M.sh) &>> run_tests.out
rm $RESULTS_DIR/*

echo "********************pipe_block_xfer_10G_20_time_block1G********************" >> run_tests.out
(time $DIRECTORY/pipe_block_xfer_10G_20_time_block1G.sh) &>> run_tests.out
rm $RESULTS_DIR/*

echo "********************pipe_block_xfer_10G_20_time_block2G********************" >> run_tests.out
(time $DIRECTORY/pipe_block_xfer_10G_20_time_block2G.sh) &>> run_tests.out
rm $RESULTS_DIR/*

echo "********************pipe_file_xfer_10G_20********************" >> run_tests.out
(time $FILE_DIR/pipe_xfer_10G_20_time_v1.sh) &>> run_tests.out
rm $RESULTS_DIR/*

  
#Dataset with 10 10G and 10 10M files
#echo "********************pipe_block_xfer_10G_10M_time_block100M********************" >> run_tests.out
#(time $DIRECTORY/pipe_block_xfer_10G_10M_time_block100M.sh) &>> run_tests.out
#rm $RESULTS_DIR/*
#
#echo "********************pipe_block_xfer_10G_10M_time_block500M********************" >> run_tests.out
#(time $DIRECTORY/pipe_block_xfer_10G_10M_time_block500M.sh) &>> run_tests.out
#rm $RESULTS_DIR/*
#
#echo "********************pipe_block_xfer_10G_10M_time_block1G********************" >> run_tests.out
#(time $DIRECTORY/pipe_block_xfer_10G_10M_time_block1G.sh) &>> run_tests.out
#rm $RESULTS_DIR/*
#
#echo "********************pipe_block_xfer_10G_10M_time_block2G********************" >> run_tests.out
#(time $DIRECTORY/pipe_block_xfer_10G_10M_time_block2G.sh) &>> run_tests.out
#rm $RESULTS_DIR/*
#
#echo "********************pipe_file_xfer_10G_10M********************" >> run_tests.out
#(time $FILE_DIR/pipe_xfer_10G_10M_time_v1.sh) &>> run_tests.out
#rm $RESULTS_DIR/*
