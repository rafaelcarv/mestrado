This project aims to compare Spark and HPAT frameworks. To install them follow the installation guid for each one of them at:
[HPAT](https://github.com/IntelLabs/HPAT.jl)
[Spark](https://spark.apache.org/downloads.html)

# Experiment 1 - Sum of the elements of an unidimensional vector

This experiment uses the files at 1D_Sum folder to execute. The file to execute the Spark code is 1D_Sum.jar, the source code was made in Scala language and is stored at the src folder. The HPAT folder is stored in its folder.

### Spark

For the Spark execution you have to give as argument:

  - The dataset text file representing the vector

This data is organazed as one number for each line, for example:
```
0.123
0.435235
0.12323
```

### HPAT
The HPAT code used is the same that can be found in the framework examples, with the difference the output print used to get data for the experiments.
The input argument for this code is also the file that will be used for the execution:
- --file=<file>

In the version used for the eperiment, the HPAT only accepted files with the HDF5 format, and the data for this experiment was generated using their 1D Sum file generator, that generates HDF5 and also a csv file to use as input for the Spark application.

### Execution

An example of execution for this experiment can be found at the Scripts folder. It has the scripts used for the distributed and parallel execution used for the research experiment.

To use these scripts it needs the arguments:
- Distributed:
    - Number of cores
    - Spark master address
    - host file for the HPAT MPI execution
- Parallel:
    - Number of cores
    - Spark master address

# Experiment 2 - K-Means

The code used for each framework execution can be found at the K-Means folder and the K-Means execution scripts can be found at the Scripts folder. They are both from the example folder from the respective framework, with the change of the output needed to gather the results for the research.

### Execution

The scripts for the K-Means execution receive the following arguments:

- Distributed:
    - Number of iterations
    - Number of centers
    - Number of cores
    - Spark master address
    - host file for the HPAT MPI execution
- Parallel:
    - Number of iterations
    - Number of centers
    - Number of cores
    - Spark master address

# Fault tolerance simulation

The simulator receives a file with a list of files. These files has to have the following data:
- Mean, standard deviation, framework name

In the current version, the simulator just get the first line as header, the second line as the HPAT data, and the third line as Spark data.
