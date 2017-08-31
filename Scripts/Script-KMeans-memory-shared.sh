#!/bin/bash

HPAT_EXAMPLE=$HOME/.julia/v0.5/HPAT/examples
HPAT_GENERATE=$HOME/.julia/v0.5/HPAT/generate_data/
SPARK=$HOME/spark-2.0.1-bin-hadoop2.7
SPARK_SBIN=$SPARK/sbin/
SPARK_BIN=$SPARK/bin/

iterations=$1
cores=$2
centers=$3

iteration_output_file=$HOME/iteration_output_file
single_execution_output_file=$HOME/single_execution_output_file
script_loop_output_file=$HOME/script_loop_output_file

for i in `seq 1 30` ;
do
   mpirun -np ${cores} julia --depwarn=no ${HPAT_EXAMPLE}/kmeans.jl --file=$HOME/data.hdf5 --centers=$centers --iterations=$iterations >> $single_execution_output_file
   ${SPARK_BIN}spark-submit --master $4 $HOME/KMeans.jar $HOME/train.txt $centers $iterations --total-executor-cores ${cores} >> $single_execution_output_file
done

for i in `seq 1 30` ;
do
    mpirun -np ${cores} julia --depwarn=no ${HPAT_EXAMPLE}/kmeans.jl --file=$HOME/data.hdf5 --centers=$centers --iterations=$iterations >> $script_loop_output_file
done

for i in `seq 1 30` ;
do
    ${SPARK_BIN}spark-submit --master $4 $HOME/KMeans.jar $HOME/train.txt $centers $iterations --total-executor-cores ${cores} >> $script_loop_output_file
done
