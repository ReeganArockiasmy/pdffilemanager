#!/bin/bash
#usage
# pdfmanager -t <tag> -s <string>
#tag=jenkins
#pattern=changelog


. ./printformat.sh --source-only  # it is load the print format source code

. ./add.sh --source-only # it is add bokk source code

. ./delete.sh --source-only # is is add delete source code

database=pdffiledata.json

usage() {
    echo "pdfmanager -t|--tag <tag> -p|--pattern <string> -h|--help"
    echo "pdfmanager -l|--list tags|books|all"
    echo "pdfmanager -a|--add"
    echo "pdfmanager -d|--delete self|user"
    echo "\"list\" and \"add\" use single command alone only"
    exit 1
}


#interactive shell script mode
interactive(){
    select var in open next inshell quit
do
    case $var in
	open|1 )
	    read -p "pagenumber: " num
	    evince -p $num -l $pattern $location$name
	    ;;
	next|2) 
	    break
	    ;;
	inshell|3 )
	    read -p "pagenumber: " num
	    pdftotext -f $num -l $num -layout $location$name -
	    ;;
	quit|q )
	    exit 0
	    ;;
	*)
	    echo "anything"
	    ;;
    esac
    done
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
	    -l| --list )
		shift
		if [ "$1" = "tags" ]
		then
		    printtags
		elif [ "$1" = "books" ]
		then
		    printbooks
		elif [ "$1" = "all" ]
		then
		     printall
		else
		    usage
		fi 
		    exit
		    ;;
	    -d| --delete )
		shift
		if [ "$1" = "self" ]
		then
		    filetobelook
		elif [ "$1" = "user" ]
		then
		    userdelete
		else
		    usage
		fi
		exit
		;;
		    
	    -a| --add )
		addbook
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
	timeout 10 pdfgrep -H --color always -n -i $pattern $location$name
	interactive
    fi
done

