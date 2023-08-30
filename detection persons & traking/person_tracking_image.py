#import bib

import cv2
import numpy as np
import imutils
from centroidtracker import CentroidTracker

#hnaya kanzlo paths d model o prototype dyalo
protopath = "MobileNetSSD_deploy.prototxt"
modelpath = "MobileNetSSD_deploy.caffemodel"

#hada howa detector dyalna
detector = cv2.dnn.readNetFromCaffe(prototxt=protopath, caffeModel=modelpath)

#hado les classes li kay9darydetectihom had lmodel
CLASSES = ["background", "aeroplane", "bicycle", "bird", "boat",
           "bottle", "bus", "car", "cat", "chair", "cow", "diningtable",
           "dog", "horse", "motorbike", "person", "pottedplant", "sheep",
           "sofa", "train", "tvmonitor"]
#hada howa tracker li kayb9a taba3na les objets maxdis hiya lmax distance li y9dar yb9a tab3o 
#maxdisap hiya lmax d time li y9dar b9a tab3a 
tracker = CentroidTracker(maxDisappeared=80, maxDistance=90)

def main():
    #hna kan9raw image
    image = cv2.imread('person_3.png')
    #hna karesiziw image 
    image = imutils.resize(image, height=500,width=1200)

    #hna kanstockiw width o height d image
    (H, W) = image.shape[:2]

    #lblob howa li kaydkhal lmodel ydetecta
    blob = cv2.dnn.blobFromImage(image, 0.007843, (W, H), 127.5)
    #hna dakhalna lblob ydetecta
    detector.setInput(blob)
    #detector.forward() xno 3ayrja3na dik detector
    person_detections = detector.forward()
    n=0
    for i in np.arange(0, person_detections.shape[2]):
        #confidence hiya di9a li khso yt3arf biha 3la dik person bach ydetectih
        confidence = person_detections[0, 0, i, 2]
        if confidence > 0.5:
            #index d object li detectina f model
            idx = int(person_detections[0, 0, i, 1])

            if CLASSES[idx] != "person":
                continue
            #person box howa li 3ay3tina ihdatiyat d dik moraba3
            person_box = person_detections[0, 0, i, 3:7] * np.array([W, H, W, H])
            (startX, startY, endX, endY) = person_box.astype("int")

            #cv2.recta hada howa li kayrsm 
            cv2.rectangle(image, (startX, startY), (endX, endY), (255, 0, 0), 2)
            n=n+1  
    cv2.putText(image, f'Total Persons : {n }', (50, 50), cv2.FONT_HERSHEY_DUPLEX, 0.8, (255, 0,0), 2)
    cv2.imshow("Detectation Des Personnes", image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

main()