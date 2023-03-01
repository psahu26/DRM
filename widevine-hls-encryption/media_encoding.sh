function createDirectoryIfNotExists () {
	if [ ! -d "$1" ]
	then
		mkdir $1
	else
		rm -v $1/*
	fi	
}
while getopts i: flag
do 
	case "${flag}" in
		i) inputpath=${OPTARG};;
	esac
done
read -p "Enter the video id : " video_id
outputpath="./encoded_videos/$video_id"
createDirectoryIfNotExists $outputpath
ffmpeg -i $inputpath -c:a copy \
	-vf "scale=-2:360" \
	-c:v libx264 -profile:v baseline -level:v 3.0 \
	-x264-params scenecut=0:open_gop=0:min-keyint=72:keyint=72 \
	-minrate 600k -maxrate 600k -bufsize 600k -b:v 600k \
	-y "$outputpath/h264_baseline_360p_600.mp4"

ffmpeg -i $inputpath -c:a copy \
	-vf "scale=-2:480" \
	-c:v libx264 -profile:v main -level:v 3.1 \
	-x264-params scenecut=0:open_gop=0:min-keyint=72:keyint=72 \
	-minrate 1000k -maxrate 1000k -bufsize 1000k -b:v 1000k \
	-y "$outputpath/h264_baseline_480p_1000.mp4"

ffmpeg -i $inputpath -c:a copy \
	-vf "scale=-2:720" \
	-c:v libx264 -profile:v main -level:v 4.0 \
	-x264-params scenecut=0:open_gop=0:min-keyint=72:keyint=72 \
	-minrate 3000k -maxrate 3000k -bufsize 3000k -b:v 3000k \
	-y "$outputpath/h264_baseline_720p_3000.mp4"

ffmpeg -i $inputpath -c:a copy \
	-vf "scale=-2:1080" \
	-c:v libx264 -profile:v high -level:v 4.2 \
	-x264-params scenecut=0:open_gop=0:min-keyint=72:keyint=72 \
	-minrate 6000k -maxrate 6000k -bufsize 6000k -b:v 6000k \
	-y "$outputpath/h264_baseline_1080p_6000.mp4"

