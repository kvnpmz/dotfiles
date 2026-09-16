#!/bin/bash

i=1
for f in *; do
  [ -e "$f" ] || continue

  ext="${f##*.}"
  suffix="_$i.$ext"
  max=$((20 - ${#suffix}))
  base="${f%.*}"
  new="${base:0:$max}$suffix"

  mv -- "$f" "$new"
  ((i++))
done

