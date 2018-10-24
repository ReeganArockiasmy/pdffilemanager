#!/bin/bash
#usage
# pdfmanager -t <tag> -s <string>
#tag=jenkins
#pattern=changelog
database=pdffiledata.json

usage() {
    echo "pdfmanager -t|--tag <tag> -p|--pattern <string> -h|--help"
    exit 1
}

if [ $# -gt 0 ];
then
    while [ "$1" != "" ];
    do
	case $1 in
	    -t | --tag )
		shift
		tag=$1
		;;
	    -p | --pattern )
		shift
		pattern=$1
		;;
	    -h| --help )
		usage
		exit
		;;
	    * )
		usage
		exit 1
	esac
	shift
    done	    
else
    usage
fi

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



