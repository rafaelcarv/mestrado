#!/bin/bash

while read file; do
    for i in $(seq 0.00 0.005 0.06); do
        for x in $(seq 1 10 100); do
            python fault-tolerance-simulator.py $file $i >> ${file}_result &
            python fault-tolerance-simulator.py $file $i >> ${file}_result &
            python fault-tolerance-simulator.py $file $i >> ${file}_result &
            python fault-tolerance-simulator.py $file $i >> ${file}_result &
            python fault-tolerance-simulator.py $file $i >> ${file}_result &
            python fault-tolerance-simulator.py $file $i >> ${file}_result &
            python fault-tolerance-simulator.py $file $i >> ${file}_result &
            python fault-tolerance-simulator.py $file $i >> ${file}_result &
            python fault-tolerance-simulator.py $file $i >> ${file}_result &
            python fault-tolerance-simulator.py $file $i >> ${file}_result &
            wait 
        done
    done  
done <files
