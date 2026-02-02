#!/bin/bash

# Converts an album to MP3 and puts it on the Desktop

if [ -z "$1" ]; then
    echo "Usage: ./convert.sh \"Artist/Album\""
    echo "Example: ./convert.sh \"Radiohead/OK Computer\""
    exit 1
fi

ARTIST_ALBUM="$1"
SOURCE_DIR="$HOME/Music/Music/Media.localized/Music/$ARTIST_ALBUM"
TARGET_DIR="$HOME/Desktop/$ARTIST_ALBUM"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Album not found at $SOURCE_DIR"
    exit 1
fi

mkdir -p "$TARGET_DIR"

echo "Converting $ARTIST_ALBUM..."

for file in "$SOURCE_DIR"/*.m4a; do
    [ -e "$file" ] || continue
    filename=$(basename "$file" .m4a)
    ffmpeg -i "$file" -codec:a libmp3lame -q:a 0 "$TARGET_DIR/$filename.mp3" -loglevel error
done

echo "✓ Done! Files ready at: $TARGET_DIR"
