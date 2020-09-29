BASE_URL="https://soho.nascom.nasa.gov/data/REPROCESSING/Completed"
YEAR="2020"
CAMERA="c3"
DATE=$1
FILE_LST=".full_1024.lst"
CREATE_MOVIE_SCRIPT="createMovieV1.py"

mkdir -p ./images/$DATE

DOWNLOAD_LINK=`echo $BASE_URL"/"$YEAR"/"$CAMERA"/"$DATE"/"$FILE_LST`
wget $DOWNLOAD_LINK -P ./images/$DATE

if [ $? -eq 0 ]
then
  cat ./images/$DATE/$FILE_LST | while read line
  do
    IMAGE_LINK=`echo $BASE_URL"/"$YEAR"/"$CAMERA"/"$DATE"/"$line`
    wget $IMAGE_LINK -P ./images/$DATE
  done
else
  IMAGE_LINK=`echo $BASE_URL"/"$YEAR"/"$CAMERA"/"$DATE"/"`
  wildCard=`echo $DATE"_*_"$CAMERA"_1024.jpg"`
  #wget -r -l1 -np $IMAGE_LINK -P ./images/$DATE -A $wildCard
  rm -rf ./images/$DATE
  wget -r -l1 -nH --cut-dirs=5 $IMAGE_LINK -P ./images -A $wildCard
  ls ./images/$DATE/$wildCard > ./images/$DATE/.full_1024.lst
fi

python3 $CREATE_MOVIE_SCRIPT $DATE
if [ $? -eq 0 ]
then
  echo "Video file creation complete. Archiving file to videos directory."
  mv $DATE.avi videos
else
  echo "Video file creation failed. Please check!!"
fi
