#!/bin/bash
function testEcho2() {
    arr=("$@")
    for i in ${arr[@]}; do
        if [[ $i == "one" ]]; then return; fi
    done
    echo OK
}

function testEcho1() {
    if [[ $(testEcho2 $@) ]]; then
        echo yes
    else
        echo no
    fi
}

array=("one" "two" "three")
testEcho1 ${array[@]}


array=("uno" "dos" "tres")
testEcho1 ${array[@]}
