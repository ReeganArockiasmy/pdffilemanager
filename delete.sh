#! /bin/bash

database=pdffiledata.json

#https://stackoverflow.com/questions/3231804/in-bash-how-to-add-are-you-sure-y-n-to-any-command-or-alias/#3232082
confirm(){
        read -r -p "${1:-Are you sure? [y/N]} " response
	case "$response" in
            [yY][eE][sS]|[yY]) 
		true
		;;
            *)
		false
		;;
	esac
}


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
	    echo $location$filename" file deleted"
	    jshon -d $filename -I -F $database < $database
	fi
    done
}

userdelete() {
    echo "Enter the file name"
    select var in `jshon -k <$database`
    do
	echo $var
	confirm && jshon -d $var -I -F $database < $database
	exit
    done   
}


#filetobelook
userdelete
