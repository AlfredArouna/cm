#!/bin/bash
# consumes 3-video, 2-audio integrated mkv from voctomix

. common.sh

SRC=$(get_src $STREAM_ROOM)

ffmpeg -y -i "http://${SRC}:7999/${STREAM}" -aspect 16:9 -threads:0 0 \
	-fflags +genpts -flags +global_header \
	-c:v libvpx -g 75 -keyint_min 75 -deadline realtime \
	-map 0:v:0 -b:v:0 3500k \
	-map 0:v:1 -b:v:1 1000k \
	\
	-ac 1 \
	-map 0:a:0 -c:a:0 libopus -vbr:a:0 off -b:a:0 32k \
	-map 0:a:1 -c:a:1 libopus -vbr:a:1 off -b:a:1 32k \
	\
	-map 0:a:0 -c:a:2 libmp3lame -b:a:2 96k \
	-map 0:a:1 -c:a:3 libmp3lame -b:a:3 96k \
	-y -f matroska pipe:
