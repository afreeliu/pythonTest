from matplotlib.pyplot import plot
from numpy import array

def draw_plot(value):
    plot(value, value**2)


a = array([1,2,3,4,5,6,7,8])

draw_plot(a)