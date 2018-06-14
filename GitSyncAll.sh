#!/bin/sh
# Run git pull for all directories

RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' # No Color

oPath="$(echo $PWD)"

cd ..

for d in */ ; do
    echo "${GRN}$d${NC}"
    cd "$d"
    git pull
    cd ..
done

cd "$oPath"
