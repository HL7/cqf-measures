#!/bin/bash

# Usage: bash ./_SOT.sh collections/cqf-measures-terminology-service-tests.postman_collection.json truthSources.md
# Check if a file name is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 input_filename output_filename"
  exit 1
fi

# Check if the output file name is provided as an argument
if [ -z "$2" ]; then
  echo "Usage: $0 input_filename output_filename"
  exit 1
fi

current_datetime=$(date '+%Y-%m-%d %H:%M:%S')
input_file="$1"
output_file="$2"
header="The following lists test sections and the required resources for those sections. This file was generated using sot.sh at $current_datetime\n"

# Use sed to extract text between delimiters and write to the output file
echo -e "$header/" > "$output_file"
sed -n 's/.*SOT@\([^@]*\)@SOT.*/\1/p' "$input_file" >> "$output_file"

echo "Results written to $output_file"
