import numpy as numpy
import tables as tables

data = numpy.loadtxt(open("/home/rafael/data.csv","rb"),delimiter=",") 
data_file = tables.open_file('data.hdf5', mode='w')
a = tables.Float64Atom()
bl_filter = tables.Filters(5, 'blosc')
data_input =  data_file.create_earray(data_file.root, 'points', a,(0,8), 'points',bl_filter,439)
data_input.append(data)

data_file.close()
