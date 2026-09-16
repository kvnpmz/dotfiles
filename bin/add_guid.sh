#!/bin/bash

for f in *; do
  [ -e "$f" ] || continue

  prefix=$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 10)
  new="${prefix}_${f}"

  while [ -e "$new" ]; do
    prefix=$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 10)
    new="${prefix}_${f}"
  done

  mv -- "$f" "$new"
done

