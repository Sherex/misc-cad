#!/bin/bash

# TODO: Don't process unchanged files
# Store checksum in file, then check when looping through?

for FILE_PATH in $(ls */*.scad); do
  FILE_NAME="$(basename $FILE_PATH '.scad')"
  DIR_PATH="$(dirname $FILE_PATH)"
  echo "########################"
  echo "Processing $FILE_NAME"
  echo "########################"
  openscad $FILE_PATH --colorscheme "Tomorrow Night" -o "$DIR_PATH/preview.png" -o "$DIR_PATH/$FILE_NAME.stl"
done

