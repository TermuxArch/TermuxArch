#!/usr/bin/env sh
#strip html code from file linux
#https://www.unix.com/linux/45584-how-remove-only-html-tags-inside-file.html
#sed -n '/^$/!{s/<[^>]*>//g;p;}' index.html
sed -n '/^$/!{s/<[^>]*>//g;p;}' "$@"
