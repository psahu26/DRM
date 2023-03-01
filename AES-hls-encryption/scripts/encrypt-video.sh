while getopts i:o:k:s: flag
do
	case "${flag}" in 
		i) inputpath=${OPTARG};;
		o) outputpath=${OPTARG};;
		k) keypath=${OPTARG};;
		s) segmentpath=${OPTARG};;
	esac
done
ffmpeg -y -i $inputpath -hls_time 10 -hls_key_info_file $keypath -hls_playlist_type vod -hls_segment_filename "$segmentpath/segment%vNo%d.ts" -hls_base_url "$segmentpath/" $outputpath
