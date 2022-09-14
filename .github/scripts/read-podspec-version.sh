#!/bin/bash

file="razorpay-customui-pod.podspec"     #the file where you keep your string name

versionLine="$(grep 's.version ' $file | sed 's/"//g' | sed "s/'//g")"
version=${versionLine##* }

echo $version

# echo "$myUser" | awk '{print $NF}'
    