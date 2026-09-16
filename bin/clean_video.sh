#!/usr/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: cleanmpv <input_file.mp4>"
    exit 1
fi

input="$1"
ext="${input##*.}"
base="${input%.*}"
output="${base}_clean.${ext}"

ffmpeg -i "$input" -map 0:v:0 -map 0:a:0 -c copy -map_metadata -1 "$output"
