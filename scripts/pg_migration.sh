#!/bin/bash

# Check dir
if [ $# -eq 0 ]; then
    echo "Error: No directory specified."
    echo "Usage: $0 <path_to_directory>"
    exit 1
fi

DIRECTORY="$1"
DB_NAME="$2"

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory '$DIRECTORY' does not exist."
    exit 1
fi

# Find all files starting with V and ending with .sql
# and print their full paths
find "$DIRECTORY" -type f -name "V*.sql" | while read -r file; do
    bash /scripts/pg_execute.sh "$file" "$DB_NAME"
done

# If no file was found, print a message
if [ -z "$(find "$DIRECTORY" -type f -name "V*.sql" -print -quit)" ]; then
    echo "No migration files V*.sql found in '$DIRECTORY'."
fi

exit 0