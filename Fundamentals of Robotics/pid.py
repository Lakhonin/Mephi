import numpy as np
class PID:
  def __init__(self, p, i, d):
    self.p = p
    self.i = i
    self.d = d
    self.prev_error = 0
    self.integral = 0 

  def step(self, target, measured, dt):
    P = target -measured
    self.integral = self.integral + P*dt 
    D = (P-self.prev_error)/dt
    self.prev_error = P
    output = P * self.p + self.i * self.integral + D * self.d
    return output
