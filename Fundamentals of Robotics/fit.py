import numpy as np
def remove_interference(measurements):
 yf = np.fft.rfft(measurements)
 xf = np.fft.rfftfreq(500*2, 1 / 500)
 points_per_freq = len(xf) / (500 / 2)
 target_idx = int(points_per_freq * 50)
 yf[target_idx] = 0
 result = np.fft.irfft(yf,measurements.size)
 return result
