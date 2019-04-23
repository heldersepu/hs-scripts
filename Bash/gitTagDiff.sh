#!/bin/bash
# sh gitTagDiff.sh v0.5.0 v0.6.0 README

IFS=$'\n'
diff_arr=($(git diff $1 $2 --stat | grep $3))

IFS='|'
for line in "${diff_arr[@]}"
do
    data=($line)
    file="$(echo "${data[0]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    echo $file
    git diff -U0 $1 $2 -- "$file" | tail
    echo ""
done
