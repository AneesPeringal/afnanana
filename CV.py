import numpy as np
import cv2
import imutils


blaclower = (0, 0, 0)
blackhigher = (179,50, 1) 
while(True):
    input("get next fr")
    cap = cv2.VideoCapture('http://192.168.0.109:4747/video')
    ret, frame = cap.read()
    blurred = cv2.GaussianBlur(frame,(5,5),0)
    hsv = cv2.cvtColor(blurred,cv2.COLOR_BGR2HSV)
    mask = cv2.inRange(hsv, (0, 0, 0), (179,50, 100));
    mask = cv2.erode(mask, None, iterations =5)
    mask = cv2.dilate(mask, None, iterations=5)
    
    contours, hierarchy = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    print(len(contours))
    
    cnt = max(contours, key = cv2.contourArea)
    
    (x,y),radius = cv2.minEnclosingCircle(cnt)
    center = (int(x),int(y))
    radius = int(radius)
    cv2.circle(mask,center,radius,(0,255,0),2)
    print ('Circle: ' + ' - Center: ' + str(center) + ' -     Radius: ' + str(radius))
    cv2.imshow("image",mask)
    cv2.waitKey(0)
    cap.release()
cv2.destroyAllWindows()
