#!/bin/bash
# check json file is empty

improve() {
    echo "Enter the file no"
    select var in `jshon -k <$database`
    do
	echo $var
	select opt in view modify quit
	do
	    case $opt in
		view|1 )o
		    location=`jshon -e $var -e location < $database`
		    location=$(echo $location | sed -e 's/\\//g' -e 's/^.\(.*\).$/\1/')
		    tags=`jshon -e $var -e tag < $database`
		    echo "Name :" $var
		    echo "location :" $location
		    echo "tags :" $tags
		    ;;
		modify|2 )
		    read -p "tags: " tags
		    eval jshon -e $var -s $tags -i tag -I -F $database < $database
		    exit
		    ;;
		quit|3 )
		    exit
		    ;;
		esac
	  done
	
    done	
}





# it call the fuction in commandline in direct
# like ./update.sh get_id
#"$@"
