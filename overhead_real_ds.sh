#! /bin/bash

blocksizes=(50 100 500 1000)
filenums=(39 24 21 15 6 9 3 3 6 12 33 30 15 15 12 9 6 3 15 6 12 9 3 6 6 6 3 6 6 6)
filesizes=(10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100)
cooley_overhead=0.05
jlse_overhead=0.1


#Real dataset overhead on Cooley
echo "********************Real dataset overhead on Cooley**********************"
for block in ${blocksizes[@]}
do
	total_overhead=0.0
	for (( i = 0; i < ${#filesizes[@]}; i++)); do
		blocknum=`expr ${filesizes[$i]} / $block`
		num=$(($blocknum * ${filenums[$i]}))
                overhead=`echo - | awk '{print '$num' * '$cooley_overhead'}'`
		total_overhead=`echo $total_overhead + $overhead | bc -l`
	done
        echo "The total overhead for block $block on Cooley is: " $total_overhead
done

#Real dataset overhead on JLSE
echo "********************Real dataset overhead on JLSE**********************"
for block in ${blocksizes[@]}
do
	total_overhead=0.0
	for (( i = 0; i < ${#filesizes[@]}; i++)); do
		blocknum=`expr ${filesizes[$i]} / $block`
		num=$(($blocknum * ${filenums[$i]}))
                overhead=`echo - | awk '{print '$num' * '$jlse_overhead'}'`
		total_overhead=`echo $total_overhead + $overhead | bc -l`
	done
        echo "The total overhead for block $block on jlse is: " $total_overhead
done
