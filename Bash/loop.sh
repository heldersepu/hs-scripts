#!/bin/bash
n=0
until [ $n -ge 2 ]
do
    echo $n && break
    n=$((n+1))
done
