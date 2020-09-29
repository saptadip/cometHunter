import sys 
import cv2 
import os

identifier = str(sys.argv[1])

image_folder = 'images/' + identifier
video_name = identifier + '.avi'

images = []
a = image_folder + '/.full_1024.lst'

fileList = open(a, 'r')
Lines = fileList.readlines()
for line in Lines:
  images.append(line.strip())

print(images)
frame = cv2.imread(os.path.join(image_folder, images[0]))
#frame = cv2.imread(images[0])
height, width, layers = frame.shape

video = cv2.VideoWriter(video_name, 0, 1, (width,height))

for image in images:
    video.write(cv2.imread(os.path.join(image_folder, image)))
    #video.write(cv2.imread(image))

cv2.destroyAllWindows()
video.release()
