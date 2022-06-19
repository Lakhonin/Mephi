import numpy
import cv2
def your_function(image):
  image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
  result = cv2.calcHist([image],[0],None,[256],[0,256])
  result,bins = numpy.histogram(image.ravel(),256,[0,256])
  return result
