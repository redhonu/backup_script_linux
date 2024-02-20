#!/bin/bash

# Exit script if command fails
set -e

# Display Help
Help() {
    echo 
    echo "folder backup"
    echo "#############"
    echo
    echo "options:"
    echo "    -f    folder to backup"
    echo "    -o    output directory"
    echo "    -r    Clear directory? true/false (default false)"
    echo "    -d    Delete files older than this many days (default 0 to disable)"
    echo "    help    Show help"
}

# Show help and exit
if [[ $1 == 'help' ]]; then
    Help
    exit
fi

# Function to check if folder exists
check_folder_exists() {
    if [ ! -d "$1" ]; then
        echo "Error: Input folder '$1' does not exist."
        exit 1
    fi
}

# Process params
while getopts ":f:o:r:d:" opt; do
    case $opt in
        f) INPUT="$OPTARG"
        ;;
        o) DIR="$OPTARG"
        ;;
        r) CLEAR="$OPTARG"
        ;;
        d) DAYSBACK="$OPTARG"
        ;;
        \?) echo "Invalid option -$OPTARG" >&2
        Help
        exit;;
    esac
done

# Fallback to environment vars and default values
: ${DIR:='/var/tmp'}
: ${CLEAR:='false'}
: ${DAYSBACK:=0}

# Verify variables
[[ -z "$INPUT" ]]  && { echo "Parameter -f input folder must be set" ; exit 1; }
[[ -z "$DIR" ]] && { echo "Parameter -d|dir is empty" ; exit 1; }
echo "DAYSBACK: $DAYSBACK"

# Check if input folder exists
check_folder_exists "$INPUT"

FOLDER_NAME=$(basename "$INPUT")

# Create backup folder
mkdir -p "${DIR}/${FOLDER_NAME}_backup"

# Delete files older than
if (($DAYSBACK > 0)); then
    find "${DIR}/${FOLDER_NAME}_backup" -type f -mtime +$DAYSBACK -delete
fi

# Cleanup backup folder
if $CLEAR ; then
    rm -rf "${DIR}/${FOLDER_NAME}_backup"/*
fi

# Create backup archive
tar -czf "${DIR}/${FOLDER_NAME}_backup/${FOLDER_NAME}_$(date '+%Y-%m-%d_%H%M%S').tar.gz" "$INPUT"

# Notify if backup has finished
if [ $? -eq 0 ]; then
    echo "The folder backup has finished: ${DIR}/${FOLDER_NAME}_backup/${FOLDER_NAME}_$(date '+%Y-%m-%d_%H%M%S').tar.gz"
else
    echo "Backup failed"
fi
