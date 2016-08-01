#! /bin/bash

DIRECTORY=/home/siliu/cksum_scripts/block_pipeline
RESULTS_DIR=/scratch/checksum_tests
FILE_DIR=/home/siliu/cksum_scripts/file_pipeline

#Dataset with 20 10G files
#echo "********************pipe_block_xfer_10G_20_time_block100M********************" >> run_tests_with_block_trick.out
#(time $DIRECTORY/pipe_block_10G_20_block100M_072216.sh) &>> run_tests_with_block_trick.out

echo "********************pipe_block_xfer_10G_20_time_block500M********************" >> run_tests_with_block_trick.out
(time $DIRECTORY/pipe_block_10G_20_block500M_072216.sh) &>> run_tests_with_block_trick.out

echo "********************pipe_block_xfer_10G_20_time_block1G********************" >> run_tests_with_block_trick.out
(time $DIRECTORY/pipe_block_10G_20_block1G_072216.sh) &>> run_tests_with_block_trick.out

#echo "********************pipe_block_xfer_10G_20_time_block2G********************" >> run_tests_with_block_trick.out
#(time $DIRECTORY/pipe_block_xfer_10G_20_time_block2G.sh) &>> run_tests_with_block_trick.out

#echo "********************pipe_file_xfer_10G_20********************" >> run_tests_with_block_trick.out
#(time $FILE_DIR/pipe_xfer_10G_20_time.sh) &>> run_tests_with_block_trick.out
  
#Dataset with 10 10G and 10 10M files
#echo "********************pipe_block_xfer_10G_10M_time_block100M********************" >> run_tests_with_block_trick.out
#(time $DIRECTORY/pipe_block_xfer_10G_10M_time_block100M.sh) &>> run_tests_with_block_trick.out
#rm $RESULTS_DIR/*
#
#echo "********************pipe_block_xfer_10G_10M_time_block500M********************" >> run_tests_with_block_trick.out
#(time $DIRECTORY/pipe_block_xfer_10G_10M_time_block500M.sh) &>> run_tests_with_block_trick.out
#rm $RESULTS_DIR/*
#
#echo "********************pipe_block_xfer_10G_10M_time_block1G********************" >> run_tests_with_block_trick.out
#(time $DIRECTORY/pipe_block_xfer_10G_10M_time_block1G.sh) &>> run_tests_with_block_trick.out
#rm $RESULTS_DIR/*
#
#echo "********************pipe_block_xfer_10G_10M_time_block2G********************" >> run_tests_with_block_trick.out
#(time $DIRECTORY/pipe_block_xfer_10G_10M_time_block2G.sh) &>> run_tests_with_block_trick.out
#rm $RESULTS_DIR/*
#
#echo "********************pipe_file_xfer_10G_10M********************" >> run_tests_with_block_trick.out
#(time $FILE_DIR/pipe_xfer_10G_10M_time.sh) &>> run_tests_with_block_trick.out
#rm $RESULTS_DIR/*
