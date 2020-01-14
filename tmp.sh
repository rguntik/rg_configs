#!/usr/bin/env bash

#text=$(cat tmp.txt)
#echo $text
#awk 'BEGIN{FS=":"; OFS="-"} {print $1,$6,$7}' /etc/passwd

awk '
BEGIN{OFS="-------------------------"}
match($1, /^\-+/) {
print $0
#print $1,$NF
}
' tmp.txt

