#!/bin/bash
STREAM="$1"

. config.sh

parse_stream(){
	eval $(echo "${STREAM}" | sed -e 's/^s\([0-9]\+\)_\(direct\|vocto\).mkv/STREAM_ROOM=\1/g')
}

get_src(){
	encoders[1]="10.73.1.3" # encoder1
	encoders[2]="10.73.2.3" # encoder2
	encoders[3]="10.73.6.3" # encoder6
	encoders[4]="10.73.99.3" # encoder mazdermind
	encoders[5]="10.73.5.3" # encoder5

	echo ${encoders[$1]}
}

parse_stream
