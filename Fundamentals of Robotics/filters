import numpy as np
def your_filter(measurements):
 ws = 40
 filtered_2 = np.concatenate((np.zeros(ws//2), np.array([np.mean(measurements[i:i+ws]) for i in range(measurements.shape[0]-ws+1)])))
 filtered_2 = measurements[:filtered_2.shape[0]] - filtered_2

 alpha = 0.4
 filtered = np.zeros(filtered_2.shape[0])
 for i in range(1, filtered_2.shape[0]):
  filtered[i] = filtered[i-1] + alpha * (filtered_2[i] - filtered[i-1])
 return filtered
