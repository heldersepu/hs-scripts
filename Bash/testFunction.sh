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
return1=$(testEcho1 ${array[@]})


array=("uno" "dos" "tres")
return2=$(testEcho1 ${array[@]})

echo "$return1  -  $return2"