#!/bin/bash

version_file=$1
line_count='wc -l $version_file | head -n1 | cut -d " " -f1'
line_count=$(eval "$line_count")

while IFS= read -r line
do
  current_line=$((current_line+1))
  if [ $current_line -gt $line_count ] 
    then
      vi $version_file -c ":1,${line_count} delete" -c ':wq'
      exit 0
  fi
  name="echo $line | head -n1 | sed -e 's/\s.*$//'"
  name=$(eval "$name")
  echo Updating $name
  latest="asdf latest $name"
  latest=$(eval "$latest")
  echo $name $latest  >> $version_file
done < "$version_file"

