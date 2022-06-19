import cv2
import os
indir = "C:/rob/in/"
#outdir = "C:/rob/out/"
outdir = "C:/rob/out1/"
os.chdir(indir)
injpgs = os.listdir(path=".")
for(injpg) in injpgs:
    imagePath = indir + injpg
    image = cv2.imread(imagePath)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    numberCascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_russian_plate_number.xml")
    numbers = numberCascade.detectMultiScale(
    gray,
    scaleFactor=1.05,
    minNeighbors=0,
    minSize=(40, 40)
    )
    
    for (x, y, w, h) in numbers:
      cv2.rectangle(image, (x, y), (x + w, y + h), (0, 255, 0), 2)
    imagePath = outdir + injpg
    status = cv2.imwrite(imagePath, image)
    print(imagePath,status)
