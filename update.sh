#!/bin/bash
# check json file is empty
jsonfile="pdffiledata.json"
database="pdffiledata.json"
# It is create a file , is not exist
if [ ! -f $jsonfile ]
then
    echo "create new file"
    echo -e "{\n\n}" > $jsonfile
fi


get_id() {
    id=`tac $jsonfile | grep -m1 -oP ".*\"id\":.*" | grep -o '[[:digit:]]*'`
    if [ -z "id" ]
    then
	id=1
    else
	let "id=id+1"
    fi
    return $id
}

# . ./delete.sh --source-only # is is add delete source code

improve() {
    echo "Enter the file no"
    select var in `jshon -k <$database`
    do
	echo $var
	select opt in view modify quit
	do
	    case $opt in
		view|1 )
		    result=`jshon -e $var < $database`
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
"$@"
