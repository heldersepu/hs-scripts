#!/bin/bash
#set -e

echo "platform:${platform}"
export platform=${platform}
if [ -z $platform ] ; then
  echo "parameter needed!"
if [ -n $platform ] ; then
  echo "parameter provided!"
fi
