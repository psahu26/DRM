function createDirectory () {
	echo "$1"

	if [ ! -d "$1" ]
	then 
		echo "creating directory...."
		mkdir "$1"
		echo "Directory created"
	else
		echo "File already exits!. Try again"
		exit 1
	fi

}
read -p "Enter the output file name : " file_name
read -p "Enter the input video path : " input_path
read -p "Enter the key info file path : " key_info_path
directory_path="../encrypted_videos/$file_name"
createDirectory "$directory_path"

ffmpeg -y -i $input_path -hls_time 10 -hls_playlist_type vod -hls_key_info_file $key_info_path -hls_segment_filename "$directory_path/segmentNo%d.ts" "$directory_path/index.m3u8"
