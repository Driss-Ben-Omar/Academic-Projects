import cv2
import csv
import imutils
import logging as log
import numpy as np
from centroidtracker import CentroidTracker
from collections import defaultdict

from testSort import Sort

protopath = "MobileNetSSD_deploy.prototxt"
modelpath = "MobileNetSSD_deploy.caffemodel"
detector = cv2.dnn.readNetFromCaffe(prototxt=protopath, caffeModel=modelpath)

CLASSES = ["background", "aeroplane", "bicycle", "bird", "boat",
        "bottle", "bus", "car", "cat", "chair", "cow", "diningtable",
        "dog", "horse", "motorbike", "person", "pottedplant", "sheep",
        "sofa", "train", "tvmonitor"]

tracker = CentroidTracker(maxDisappeared=80, maxDistance=90)
def non_max_suppression_fast(boxes, overlapThresh):
        try:
            if len(boxes) == 0:
                return []

            if boxes.dtype.kind == "i":
                boxes = boxes.astype("float")

            pick = []

            x1 = boxes[:, 0]
            y1 = boxes[:, 1]
            x2 = boxes[:, 2]
            y2 = boxes[:, 3]

            area = (x2 - x1 + 1) * (y2 - y1 + 1)
            idxs = np.argsort(y2)

            while len(idxs) > 0:
                last = len(idxs) - 1
                i = idxs[last]
                pick.append(i)

                xx1 = np.maximum(x1[i], x1[idxs[:last]])
                yy1 = np.maximum(y1[i], y1[idxs[:last]])
                xx2 = np.minimum(x2[i], x2[idxs[:last]])
                yy2 = np.minimum(y2[i], y2[idxs[:last]])

                w = np.maximum(0, xx2 - xx1 + 1)
                h = np.maximum(0, yy2 - yy1 + 1)

                overlap = (w * h) / area[idxs[:last]]

                idxs = np.delete(idxs, np.concatenate(([last],
                                                    np.where(overlap > overlapThresh)[0])))

            return boxes[pick].astype("int")
        except Exception as e:
            print("Exception occurred in non_max_suppression : {}".format(e))
class Video:
   


    def mainVideo():
        show=0
        cap = cv2.VideoCapture('testvideo2.mp4')
    
        total_frames = 0
        centroid_dict = defaultdict(list)
        object_id_list = []

        while True:
            ret, frame = cap.read()
            frame = imutils.resize(frame, width=600)
            total_frames = total_frames + 1

            (H, W) = frame.shape[:2]

            blob = cv2.dnn.blobFromImage(frame, 0.007843, (W, H), 127.5)

            detector.setInput(blob)
            person_detections = detector.forward()
            rects = []
            for i in np.arange(0, person_detections.shape[2]):
                confidence = person_detections[0, 0, i, 2]
                if confidence > 0.5:
                    idx = int(person_detections[0, 0, i, 1])

                    if CLASSES[idx] != "person":
                        continue

                    person_box = person_detections[0, 0, i, 3:7] * np.array([W, H, W, H])
                    (startX, startY, endX, endY) = person_box.astype("int")
                    rects.append(person_box)

            boundingboxes = np.array(rects)
            boundingboxes = boundingboxes.astype(int)
            rects =non_max_suppression_fast(boundingboxes, 0.3)

            objects = tracker.update(rects)
            total=0
            x=10
            n=0
            m=10
            log.basicConfig(filename='warning.log',level=log.INFO)
            for (objectId, bbox) in objects.items():
                n=((objectId+1)*100)%255
                m=(m+n/255)%255
                x=(x+m/255)%255
                x1, y1, x2, y2 = bbox
                x1 = int(x1)
                y1 = int(y1)
                x2 = int(x2)
                y2 = int(y2)

                cX = int((x1 + x2) / 2.0)
                cY = int((y1 + y2) / 2.0)
                #dik lpoint li katb9a las9a f object
                cv2.circle(frame, (cX, cY), 4, (n, m, x), -1)
                
                total=total+1
                centroid_dict[objectId].append((cX, cY))
                if objectId not in object_id_list:
                    object_id_list.append(objectId)
                    start_pt = (cX, cY)
                    end_pt = (cX, cY)
                    cv2.line(frame, start_pt, end_pt, (0, 255, 0), 2)
                else:
                    l = len(centroid_dict[objectId])
                    for pt in range(len(centroid_dict[objectId])):
                        if not pt + 1 == l:
                            start_pt = (centroid_dict[objectId][pt][0], centroid_dict[objectId][pt][1])
                            end_pt = (centroid_dict[objectId][pt + 1][0], centroid_dict[objectId][pt + 1][1])
                            cv2.line(frame, start_pt, end_pt, (n, m, x), 2)
                            print(objectId)
                            print(start_pt)
                            print(end_pt)
                log.info("WARNING person : "+str(objectId)+    "    beetwin    "+str(start_pt)+  "   and     "   +str(end_pt))
                #listLines=Sort()
                #result=listLines.main()                 
                cv2.rectangle(frame, (x1, y1), (x2, y2), (n, m, x), 2)
                text = "ID: {}".format(objectId)
                cv2.putText(frame, text, (x1, y1-5), cv2.FONT_HERSHEY_COMPLEX_SMALL, 1, (n, m, x), 1)
            
            
            cv2.putText(frame, f'Total Persons : {total }', (50, 50), cv2.FONT_HERSHEY_DUPLEX, 0.8, (255, 0,0), 2)
            cv2.imshow("Detection personne and draw traking", frame)
            key = cv2.waitKey(1)
            if key == ord('w'):
                break   
        cv2.destroyAllWindows()

    mainVideo()
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
