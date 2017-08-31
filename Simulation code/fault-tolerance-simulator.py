import time
import sys
import random

def get_experiment_data(file_name):
    experiment_data = open(file_name, 'r')
    header = experiment_data.readline()
    hpat_data = experiment_data.readline()
    spark_data = experiment_data.readline()
    return header, hpat_data, spark_data

def parse_line(line):
    mean, dp_value, name = line.split(',')
    return float(mean), float(dp_value), name

def fault_occurred(fault_probability):
    if (fault_probability == 0.0):
        return False
    if (fault_probability == 1.0):
        return True
    step_probability_value = random.uniform(0,1)
    return (step_probability_value <= fault_probability)

def get_spark_fault_time(spark_time, simulation_step):
    time_slice = spark_time/3.0
    
    beginning_time = 6.35
    beginning_sd = 2.06
    middle_time = 7.08
    middle_sd = 1.76
    end_time = 10.3
    end_sd = 4.44
    if (simulation_step < time_slice):
        return random.uniform(beginning_time - beginning_sd, beginning_time + beginning_sd)
    elif (simulation_step >= time_slice and simulation_step < (time_slice * 2.0)):
        return random.uniform(middle_time - middle_sd, middle_time + middle_sd)
    return random.uniform(end_time - end_sd, end_time + end_sd)

def simulate_fault(file_name, fault_probability):
    header, hpat_data, spark_data = get_experiment_data(file_name)
    
    hpat_mean, hpat_dp, hpat_name = parse_line(hpat_data)
    spark_mean, spark_dp, spark_name = parse_line(spark_data)
    
    hpat_simulated_runtime = random.uniform(hpat_mean - hpat_dp, hpat_mean + hpat_dp) * 60.0   
    spark_simulated_runtime = random.uniform(spark_mean - spark_dp, spark_mean + spark_dp) * 60.0
    
    last_fault_step = 0.0
    hpat_fault_time = 0.0
    
    hpat_is_executing = True
    spark_is_executing = True

    amount_of_steps = int(spark_simulated_runtime)
    i = 0
    start = time.time()
    while  (hpat_is_executing or spark_is_executing):
        if (i - last_fault_step >= hpat_simulated_runtime):
            hpat_is_executing = False
        if (i >= spark_simulated_runtime):
            spark_is_executing = False
        if (fault_occurred(fault_probability)):
            if (hpat_is_executing):
                 hpat_simulated_runtime = random.uniform(hpat_mean - hpat_dp, hpat_mean + hpat_dp) * 60.0
                 hpat_fault_time = hpat_fault_time + (i - last_fault_step)
            if (spark_is_executing):
                 spark_simulated_runtime = spark_simulated_runtime + get_spark_fault_time(spark_simulated_runtime, i)
            last_fault_step = i
        if (time.time() - start >= 2.0):
            break
        i = i + 1
    hpat_simulated_runtime = hpat_simulated_runtime + hpat_fault_time
    return "%f,%f,HPAT\n%f,%f,Spark" % (hpat_simulated_runtime, fault_probability, spark_simulated_runtime, fault_probability)

data_file = sys.argv[1]
chance_to_fault = sys.argv[2]

print simulate_fault(data_file, float(chance_to_fault))
