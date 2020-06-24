#!/bin/bash

#Getting current tag
version=$(git describe --abbrev=0 --tags)

echo "Current version: $version"

#check that current tag correctly formatted
re="v[0-9].[0-9].[0-9]"
if [[ $version != $re* ]]
then
	echo "current tag is $version"
	echo "tag must be formatted as v[major].[minor].[patch], where major, minor, and patch are integers"
	exit 1
fi

#get what to increment from user
read -p "What would you like to increment? (major, minor, or patch) " input

version=${version:1} # Remove the starting v from the tag 
IFS='.' read -r -a array <<< $version
arr=($array)

major=${arr[0]}
minor=${arr[1]}
patch=${arr[2]}

while [ "$input" != "minor" ] && [ "$input" != "major" ] && [ "$input" != "patch" ] ; do
	echo "Input must be major, minor, or patch"
	read -p "What would you like to increment? (major, minor, or patch) " input
done

read -p "Add a message for the tag: " message

#generate new tag
new_major=$major
new_minor=$minor
new_patch=$patch

case $input in 
	major)
		new_major="$(($new_major + 1))"
		new_minor=0
		new_patch=0
		;;
	minor)
		new_minor="$(($new_minor + 1))"
		new_patch=0
		;;
	patch)
		new_patch="$(($new_patch + 1))"
		;;
esac

echo "new major: $new_major"
echo "new minor: $new_minor"
echo "new patch: $new_patch"

#create tag

new_tag="v${new_major}.${new_minor}.${new_patch}"
git tag -a $new_tag -m "$message"
git push --tags

#confirmation to user
echo "New tag will be $new_tag"
