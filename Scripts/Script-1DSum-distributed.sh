#!/bin/bash

HPAT_EXAMPLE=$HOME/.julia/v0.5/HPAT/examples
HPAT_GENERATE=$HOME/.julia/v0.5/HPAT/generate_data/
SPARK=$HOME/spark-2.0.0-bin-hadoop2.7
SPARK_SBIN=$SPARK/sbin/
SPARK_BIN=$SPARK/bin/

cores=$1
master=$2
hostfile=$3

sequential_execution_output_file=./sequential_execution_output_file
alternate_output_file=./alternate_output_file

for i in `seq 1 30` ;
do
   mpirun -n ${cores} —-hostfile $hostfile julia --depwarn=no ${HPAT_EXAMPLE}/1D_sum.jl --file=./1D_large.hdf5 >> $alternate_output_file
   ${SPARK_BIN}spark-submit --master $master ./1D_Sum.jar ./1D_large.csv --total-executor-cores ${cores} >> $alternate_output_file
done

for i in `seq 1 30` ;
do
   mpirun -n ${cores} —-hostfile $hostfile julia --depwarn=no ${HPAT_EXAMPLE}/1D_sum.jl --file=./1D_large.hdf5 >> $sequential_execution_output_file
done

for i in `seq 1 30` ;
do
   ${SPARK_BIN}spark-submit --master $master ./1D_Sum.jar ./1D_large.csv --total-executor-cores ${cores} >> $sequential_execution_output_file
done
