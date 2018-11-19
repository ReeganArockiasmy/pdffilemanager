#! /bin/bash

database=pdffiledata.json


# it is check database filename and location is available or deleted
filetobelook() {
    for filename in `jshon -k < $database`
    do
	location=`jshon -e $filename -e location < $database`
	location=$(echo $location | sed -e 's/\\//g' -e 's/^.\(.*\).$/\1/')
	if [ -a $location$filename ]
	then
	    echo $filename > /dev/null
	else
	    echo $location$filename
	    echo "file not available"
	    jshon -d $filename -I -F $database < $database
	fi
    done
    
}

filetobelook
