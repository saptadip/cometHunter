import sys 
import cv2 
import os

identifier = str(sys.argv[1])
image_folder = 'images/' + identifier
video_name = identifier + '.avi'
images = []
a = image_folder + '/.full_1024.lst'

print("Creating movie from the image files")

fileList = open(a, 'r')
Lines = fileList.readlines()
for line in Lines:
  images.append(line.strip())

frame = cv2.imread(os.path.join(image_folder, images[0]))
height, width, layers = frame.shape

video = cv2.VideoWriter(video_name, 0, 1, (width,height))

for image in images:
    video.write(cv2.imread(os.path.join(image_folder, image)))

cv2.destroyAllWindows()
video.release()
