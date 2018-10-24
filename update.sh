#!/bin/bash
# check json file is empty
jsonfile="pdffiledata.json"

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


# it call the fuction in commandline in direct
# like ./update.sh get_id
"$@"
