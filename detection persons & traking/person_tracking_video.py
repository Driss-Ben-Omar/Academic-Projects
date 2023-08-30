import cv2
import imutils
import numpy as np
from centroidtracker import CentroidTracker

protopath = "MobileNetSSD_deploy.prototxt"
modelpath = "MobileNetSSD_deploy.caffemodel"
detector = cv2.dnn.readNetFromCaffe(prototxt=protopath, caffeModel=modelpath)


CLASSES = ["background", "aeroplane", "bicycle", "bird", "boat",
           "bottle", "bus", "car", "cat", "chair", "cow", "diningtable",
           "dog", "horse", "motorbike", "person", "pottedplant", "sheep",
           "sofa", "train", "tvmonitor"]

tracker = CentroidTracker(maxDisappeared=80, maxDistance=90)

#had function hiya li katklf bach trtb lmoraba3at 3la les object kat3ti kol moraba3 id o howa li
#kayb9a 3a9l 3la xmn object yb9a mtracki 
#boxes howa dakxi li hda dik object
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


def main():
    cap = cv2.VideoCapture("testvideo2.mp4")

    
    total_frames = 0

    while True:
        ret, frame = cap.read()
        frame = imutils.resize(frame,height=500, width=700)
        total_frames = total_frames + 1

        (H, W) = frame.shape[:2]
        blob = cv2.dnn.blobFromImage(frame, 0.007843, (W, H), 127.5)

        detector.setInput(blob)
        person_detections = detector.forward()
        #rects homa  les objects li detectaw 
        rects = []
        total=0
        #np.arange hiya array d tsawar
        for i in np.arange(0, person_detections.shape[2]):
            confidence = person_detections[0, 0, i, 2]
            if confidence > 0.5:
                idx = int(person_detections[0, 0, i, 1])

                if CLASSES[idx] != "person":
                    continue
                #person box hiya li katrsm dik moraba3at 
                person_box = person_detections[0, 0, i, 3:7] * np.array([W, H, W, H])
                (startX, startY, endX, endY) = person_box.astype("int")
                rects.append(person_box)

        boundingboxes = np.array(rects)
        boundingboxes = boundingboxes.astype(int)
        
        rects = non_max_suppression_fast(boundingboxes, 0.3)
        

        objects = tracker.update(rects)
        for (objectId, bbox) in objects.items():
            x1, y1, x2, y2 = bbox
            x1 = int(x1)
            y1 = int(y1)
            x2 = int(x2)
            y2 = int(y2)
            total=total+1

            cv2.rectangle(frame, (x1, y1), (x2, y2), (100, 100, 100), 2)
            text = "Num:{}".format(objectId)
            cv2.putText(frame, text, (x1, y1-5), cv2.FONT_HERSHEY_COMPLEX_SMALL, 1, (100, 100, 100), 1)
        
        cv2.putText(frame, f'Total Persons : {total }', (50, 50), cv2.FONT_HERSHEY_DUPLEX, 0.8, (255, 0,0), 2)
        cv2.putText(frame, f'Total frames : {total_frames }', (50, 100), cv2.FONT_HERSHEY_DUPLEX, 0.8, (255, 0,0), 2)
        cv2.imshow("Detectation Des Personnes", frame)
        key = cv2.waitKey(1)
        if key == ord('w'):
            break
    print(format(objectId+1))
    cv2.destroyAllWindows()


main()