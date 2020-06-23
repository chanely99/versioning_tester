#!/bin/bash

#Getting current version
version=$(git describe --abbrev=0 --tags)
version=${version:1} # Remove the v in the tag v0.37.10 for example
IFS='.' read -r -a array <<< $version
arr=($array)
echo "$arr"