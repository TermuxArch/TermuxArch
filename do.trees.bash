#!/bin/env bash
# Copyright 2019 (c) all rights reserved
# by S D Rausty https://sdrausty.github.io
# Checks sha512sum files: sha512sum -c trees.sha512sum.sum
# Creates and checks trees.*.sum files: ./do.trees.bash
#####################################################################
set -eu
rm -f *.sum
FILELIST=( $(find . -type f | grep -v .git | sort) )
CHECKLIST=(md5sum sha1sum sha224sum sha256sum sha384sum sha512sum)
for SCHECK in "${CHECKLIST[@]}"
do
	for FILE in "${FILELIST[@]}"
	do
 		printf "%s\\n" "Creating $SCHECK for $FILE..."
		"$SCHECK" "$FILE" >> trees."$SCHECK".sum
	done
 	printf "\\n%s\\n" "Checking $SCHECK using trees.$SCHECK.sum..."
	"$SCHECK" -c trees."$SCHECK".sum
	printf "\\n"
done
# do.trees.sh EOF
