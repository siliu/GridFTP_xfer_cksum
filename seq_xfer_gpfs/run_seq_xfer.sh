#! /bin/bash

DIRECTORY=/home/siliu/cksum_scripts/seq_xfer_gpfs

#Dataset with 20 10G files
for i in {1..3}
do
        echo "Run-$i: " >> run_seq_xfer.out        

	echo "********************10G 500M dataset seq xfer on GPFS ********************" >> run_seq_xfer.out
	$DIRECTORY/seq_xfer_cksum_10G_500M.sh &>> run_seq_xfer.out

	echo "********************10G 500M dataset seq xfer md5sum on GPFS********************" >> run_seq_xfer.out
	$DIRECTORY/seq_xfer_cksum_10G_500M_md5sum.sh &>> run_seq_xfer.out
	
        echo "********************20 10G dataset seq xfer on GPFS********************" >> run_seq_xfer.out
	$DIRECTORY/seq_xfer_cksum_20_10G.sh &>> run_seq_xfer.out

	echo "********************20 10G dataset seq xfer md5sum on GPFS********************" >> run_seq_xfer.out
	$DIRECTORY/seq_xfer_cksum_20_10G_md5sum.sh &>> run_seq_xfer.out
done
	

