#!/bin/bash
#usage
# pdfmanager -t <tag> -s <string>
tag=jenkins
pattern=changelog
database=pdffiledata.json

usage() {
    echo "pdfmanager -t <tag> -s <string>"
    exit 1
}

# if [ $# -eq 4 ];
# then
    
# else
#     usage
# fi

for name in `jshon -k < $database`
do
    result=`jshon -e $name -e tag < $database`
    if [ \"$tag\" == $result ]
    then
	location=`jshon -e $name -e location < $database`
        location=$(echo $location | sed -e 's/\\//g' -e 's/^.\(.*\).$/\1/')
	pdfgrep -H --color always -n -i $pattern $location$name
    fi
done



