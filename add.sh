#! /bin/bash
jsonfile=pdffiledata.json
ignorefile=ignoredir.txt

# find cmd read the ignoredir and text file
makefindcmd(){
    findcmd="find $HOME -type d \( "
    grepcmd=""
    for igndir in `cat $ignorefile`
    do
	if [[ $igndir == *pdf ]]
	then
	    grepcmd=$grepcmd"| grep -v "$igndir
	else
	    findcmd=$findcmd$"-path "$igndir" -o "
	fi
    done
    findcmd=${findcmd::-3}
    findcmd=$findcmd"\) -prune -o -name \"*.pdf\" -print"
    findcmd=$findcmd$grepcmd
}

# it is check book is avaible in json file
bookIsThere(){
    if jshon -k < $jsonfile | grep -q $filename
    then
	return 1
    fi
}

makefindcmd
for filepath in `eval $findcmd`
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
		echo $dir$filename >> $ignorefile
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
log_user 0
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
