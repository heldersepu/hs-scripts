#!/bin/sh
# Run git pull for all directories

oPath="$(echo $PWD)"

cd ..

for d in */ ; do
    echo "$d"
    cd "$d"
    git pull
    cd ..
done

cd "$oPath"
