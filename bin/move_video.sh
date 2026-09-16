#!/usr/bin/bash

src="${1:-.}"
dest="$HOME/Downloads"
mkdir -p "$dest"

find "$src" -type f \
  \( -iname '*.mp4' -o -iname '*.mkv' -o -iname '*.mov' -o -iname '*.av1' -o -iname '*.ts' \) \
  ! -path "$dest/*" -print0 |
while IFS= read -r -d '' file; do
    name=$(basename "$file")
    target="$dest/$name"
    n=1

    while [[ -e "$target" ]]; do
        target="$dest/${name%.*}.$n.${name##*.}"
        ((n++))
    done

    mv -- "$file" "$target"
done
