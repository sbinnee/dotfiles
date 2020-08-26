#!/bin/sh
FILE_PATH="${1}"
# FILE_EXTENSION="${FILE_PATH#*.}"
FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER=$(echo ${FILE_EXTENSION} | tr '[:upper:]' '[:lower:]')
# printf "FileType: .%s\n---\n" "$FILE_EXTENSION_LOWER"

case "${FILE_EXTENSION_LOWER}" in
	tar|tgz|xz|gz) tar tf "$1";;
	zip) unzip -l "$1";;
	md) glow -s dark "$1" -w 72;;
	pdf) pdftotext "$1" -;;
	jpeg|jpg|png|gif) chafa -w 1 -c 240 -s 40x13 "$1"; exiv2 "$1";;
	# jpeg|jpg|png|gif) exiv2 "$1";;
	# mkv|webm|mp4) mediainfo "$1" | tr -d '[:blank:]';;
	mkv|webm|mp4) mediainfo "$1" | grep -P 'Complete name|File size|Duration|Width|Height|Display aspect ratio' | tr -d '[:blank:]' | sed 's/:/   \t/';;
	m4a) mediainfo "$1" | tr -d '[:blank:]' | sed 's/:/   \t/';;
	*) highlight -O ansi "$1" || cat "$1";;
esac

