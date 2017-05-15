#!/bin/bash

if [ -z "$1" ] ; then
        echo "You must specify a commit message"
        exit 1
fi

git add -A .
git commit -a -m "$1"
git push origin blots-changes

