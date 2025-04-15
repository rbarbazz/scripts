#!/bin/bash

# Convert an album to mp3
ARTIST_ALBUM="Artist/Album"
SOURCE_DIR="$HOME/Music/Music/Media.localized/Music/$ARTIST_ALBUM"
TARGET_DIR="$HOME/Desktop/$ARTIST_ALBUM"

mkdir -p "$TARGET_DIR"

for file in "$SOURCE_DIR"/*.m4a; do
    filename=$(basename "$file" .m4a)
    ffmpeg -i "$file" -codec:a libmp3lame -q:a 0 "$TARGET_DIR/$filename.mp3"
done
