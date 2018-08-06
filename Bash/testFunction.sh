#!/bin/bash
function testEcho() {
   arr=("$@")
   for i in "${arr[@]}";
      do
          echo "$i"
      done

}

array=("one" "two" "three")
testEcho ${array[@]}
