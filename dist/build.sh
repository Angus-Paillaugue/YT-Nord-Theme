#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR


# Directory to zip
directory_to_zip="../"

# Colors
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

# Create temporary directory
[ -e "./build.zip" ] && rm ./build.zip
rm -rf ./temp
mkdir ./temp

# Copy directory contents to temporary directory, omitting specified files and directories
rsync -av --exclude-from='./omit.txt' "$directory_to_zip" ./temp

# Zip the temporary directory
cd ./temp
zip -r ../build.zip ./
cd ../

# Remove temporary directory
rm -r ./temp

echo -e "\n${GREEN}  ${ENDCOLOR}Build completed successfully!"
