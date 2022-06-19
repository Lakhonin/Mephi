import numpy as np
import matplotlib.pyplot as plt
def analyze(data_wave):
 wave_array = wave_to_array(data_wave)

 FFT = abs(np.fft.fft(wave_array))
 freqs = np.fft.fftfreq(len(FFT), (1.0/48000))

 plt.plot(freqs[range(len(FFT)//2)], FFT[range(len(FFT)//2)])
 plt.xlabel('Frequency (Hz)')
 plt.ylabel('Amplitude')
 plt.xlim(270,600)
 #plt.xlim(19500,21500)
 plt.show()

analyze(example_data)

def analyze(data_wave):
 wave_array = wave_to_array(data_wave)
 len = int(wave_array.size/150)
 result=np.zeros(150,dtype=bool)
 rez = []
 prev = 0
 for i in range(150):
  wave= wave_array[i*len:len*(i+1)]
  yf = np.fft.rfft(wave,25000)
  fft_abs = np.abs(yf)
  if(np.max(fft_abs[10250:10500])>230 and np.max(fft_abs[280:290])<200):
   result[i]=True
  else:
   result[i]=False
 return result
