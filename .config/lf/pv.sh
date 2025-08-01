#!/bin/bash

# image preview using sixel
if "$(uname)" = "Linux"
then
    if pidof Hyprland > /dev/null
    then
        case "$(file -Lb --mime-type -- "$1")" in
            image/*)
                chafa -f sixels -s "$2x$3" --animate off --polite on "$1"
                exit 1
                ;;
        esac
    fi
else
    # for macos
    case "$(file -Lb --mime-type -- "$1")" in
        image/*)
            chafa -f sixels -s "$2x$3" --animate off --polite on "$1"
            exit 1
            ;;
    esac
fi

FILE_PATH="${1}"
# FILE_EXTENSION="${FILE_PATH#*.}"
FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER=$(echo ${FILE_EXTENSION} | tr '[:upper:]' '[:lower:]')
# printf "FileType: .%s\n---\n" "$FILE_EXTENSION_LOWER"

case "${FILE_EXTENSION_LOWER}" in
    tar|tgz|xz|bz2|gz|zst) tar tf "$1";;
    zip) unzip -l "$1";;
    rar) unrar l "$1";;
    md) bat --style=numbers --paging=never --color=always "$1";;
    # md) glow -s dark "$1" -w 72;;
    pdf) pdftotext "$1" -;;
    jpeg|jpg|png|gif) chafa -w 1 -c 240 -s 40x13 "$1"; exiv2 "$1";;
    tif|tiff) mediainfo "$1" | tr -d '[:blank:]' | sed 's/:/:\t/';;
    # jpeg|jpg|png|gif) exiv2 "$1";;
    # mkv|webm|mp4) mediainfo "$1" | tr -d '[:blank:]';;
    mkv|webm|mp4|wmv) print_mediainfo "$1";;
    mp3|m4a|aac|opus|m4b) mediainfo "$1" | tr -d '[:blank:]' | sed 's/:/   \t/';;
    json) jq 'if type == "object" then keys elif type == "array" then .[] else empty end' "$1";;
    *) bat --style=numbers --paging=never --color always "$1";;
    # *) highlight -O ansi "$1" || cat "$1";;
esac
