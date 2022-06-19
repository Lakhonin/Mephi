import matplotlib.pyplot as plt
import numpy as np
def sigmoid(x):
  # Сигмоидная функция активации: f(x) = 1 / (1 + e^(-x))
  return 1 / (1 + np.exp(-x))
def sigmoid_prime(x):
  # Производная сигмоиды: f'(x) = f(x) * (1 - f(x))
  fx = sigmoid(x)
  return fx * (1 - fx)
class ANN:
  def __init__(self):
    size0 = 784
    size1 = 512
    #size2 = 128
    size3 = 10
    scale = 1 / size0 ** .5 # используйте в np.random.normal
    np.random.seed(0)
    # your code here
    self.w1 = np.random.normal(loc =0, scale=scale, size=(size0, size1))
    self.w2 = np.random.normal(loc =0, scale=scale, size=(size1, size3))
    #self.w3 = np.random.normal(loc =0, scale=scale, size=(size2, size3))
    self.b1 = np.random.normal(loc =0, scale=scale, size=(1,size1))
    self.b2 = np.random.normal(loc =0, scale=scale, size=(1,size3))
    #self.b3 = np.random.normal(loc =0, scale=scale, size=(1,size3))
    
  def feedforward(self, x):
    # your code here
   # hidden
   z1 = x.dot(self.w1)# input from layer 1
   a1 = sigmoid(z1)# out put of layer 2
     
    # Output layer
   z2 = a1.dot(self.w2)# input of out layer
   a2 = sigmoid(z2)# output of out layer
   return(a2)

  def backpropagation(self, x, y, learning_rate):
   # hidden layer
   z1 = x.dot(self.w1)# input from layer 1
   a1 = sigmoid(z1)# output of layer 2
     
    # Output layer
   z2 = a1.dot(self.w2)# input of out layer
   a2 = sigmoid(z2)# output of out layer
    # error in output layer
   d2 =(a2-y)
   d1 = np.multiply((self.w2.dot((d2.transpose()))).transpose(),(np.multiply(a1, 1-a1)))
 
    # Gradient for w1 and w2
   w1_adj = x.transpose().dot(d1)
   w2_adj = a1.transpose().dot(d2)
     
    # Updating parameters
   self.w1 = self.w1-(learning_rate*(w1_adj))
   self.w2 = self.w2-(learning_rate*(w2_adj))
     
   return(self.w1, self.w2)
def mse(a, b):
  return np.mean((a-b)**2) # your code here

def acc(a, b):
  return np.mean(1-(sum(a)/len(b))) # your code here
