#!/bin/bash

file="razorpay-customui-pod.podspec"     #the file where you keep your string name

NEW_PODSPEC_VERSION=$1

myUser="$(grep 's.version ' $file)"
lastVal=${myUser##* }

sed -i -e "s/$lastVal/'$NEW_PODSPEC_VERSION'/g" $file

echo "$lastVal"

# echo "$myUser" | awk '{print $NF}'
    