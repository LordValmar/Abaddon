#!/bin/bash

if [ -z $1 ]; then
  echo "Usage: fix-xml.sh <filename>"
  exit 1
fi

FILENAME=$@
XMLLINT=`which xmllint 2> /dev/null`

if [ -z $XMLLINT ]; then
  echo "xmllint not found"
  exit 1
fi

IFS=$'\n'
for file in $@ ; do
  echo "Processing \"${file}\""
  TMP_FILENAME=$(mktemp)

  if [ ! -e "$file" ]; then
    echo "File ${file} does not exist"
  fi

  $XMLLINT --format "$file" > $TMP_FILENAME 2> /dev/null

  if [ $? -gt "0" ]; then
    echo "Error in XML file \"${file}\"; original file unprocessed"
    rm -f $TMP_FILENAME
  else
    cp $TMP_FILENAME "$file"
  fi
done
