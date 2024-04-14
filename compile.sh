#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

# Creates or empty the ./prod-css directory
if [ ! -d ./prod-css ]; then
  mkdir $SCRIPT_DIR/prod-css
else
  rm $SCRIPT_DIR/prod-css/*
fi

# Compiles all the ./dev-css/*.scss files into ./prod-css/*.css
find $SCRIPT_DIR/dev-css -print0 | while IFS= read -r -d '' file_path
do 
  # If is a file
  if [ -f "$file_path" ]; then
    file_name="$(basename -- $file_path)"
    file_name_without_ext="${file_name%.*}"
    echo -e "${GREEN}󰑥 ${ENDCOLOR}$file_name"
    sass --no-source-map $file_path:prod-css/$file_name_without_ext.css
  fi
done

echo -e "\n${GREEN} ${ENDCOLOR}CSS file successfully compiled !"