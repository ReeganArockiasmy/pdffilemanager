#! /bin/bash
jsonfile=pdffiledata.json

bookIsThere(){
    if jshon -k < $jsonfile | grep -q $filename
    then
	return 1
    fi
}

#for filepath in `find $HOME -name \*.pdf`
for filepath in `find $PWD -name \*.pdf`
do
filename=$(basename "$filepath")
dir=$(dirname "$filepath")"/"
if bookIsThere
then
    echo $filename
    select var in open tags noadd exit
    do
	case $var in
	    open|1 )
		evince $dir$filename
		;;
	    tags|2 )
		read -p "tags: " tags
		break
		;;
	    noadd|3 )
		break
		;;
	    exit|4 )
		exit 0
		;;
	    *)
		echo "anything"
		;;
	esac 
    done
    
    if [[ $var != "noadd" ]]
    then
	expect <<EOF
set timeout -1
spawn ./input.sh
expect "name\r"
send -- "$filename\r"
expect "location\r"
send -- "$dir\r"
expect "tags\r"
send -- "$tags\r"
expect eof
EOF
    fi
fi    
done
