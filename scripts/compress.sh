#!/bin/bash

echo > "$1"
for file in $2/*.$3; do
  filename=$(echo "$file" | sed -E 's/.*\/([^\/]+)$/\1/g' | sed -E 's/\.| |-/_/g')
  echo -e "static char $filename[] = {$(hexdump "$file" -ve '1/1 "0x%.2x,"')0x00};\nstatic const long unsigned int ${filename}_size = sizeof($filename);\n" >> "$1"
done
