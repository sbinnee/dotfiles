#!/bin/sh

FILE_PATH="${1}"
FILE_EXTENSION="${FILE_PATH#*.}"
FILE_EXTENSION_LOWER=$(echo ${FILE_EXTENSION} | tr '[:upper:]' '[:lower:]')

case "${FILE_EXTENSION_LOWER}" in
	*tar*|tgz) tar tf "$1";;
	zip) unzip -l "$1";;
	md) glow -s dark "$1";;
	pdf) pdftotext "$1" -;;
	jpeg|jpg|png|gif) exiv2 "$1";;
	*) highlight -O ansi "$1" || cat "$1";;
esac

