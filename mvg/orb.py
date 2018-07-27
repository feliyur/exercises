import os
import timeit

import numpy as np
import cv2
from matplotlib import pyplot as plt

photos_dir = r'/home/yuri/Desktop/Fichiers/2017/Yuri-photos/Camera'
photo_file = os.path.join(photos_dir, r'20170422_143622.jpg')

img = cv2.imread(photo_file, 0)


# Initiate STAR detector
orb = cv2.ORB_create()


# find the keypoints with ORB
kp = orb.detect(img, None)

# compute the descriptors with ORB
kp, des = orb.compute(img, kp)


# timeit.timeit('kp = orb.detect(img, None); kp, des = orb.compute(img, kp)', number=10)

# draw only keypoints location,not size and orientation
img2 = cv2.drawKeypoints(img,kp,None, color=(0,255,0), flags=0)
plt.imshow(img2),plt.show()

# cv2.imshow('abc', img)
# cv2.waitKey()
# plt.imshow(img)
# plt.show()