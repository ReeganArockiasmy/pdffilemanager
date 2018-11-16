#! /bin/bash

database=pdffiledata.json
# print all tags
printtags(){
    
    for name in `jshon -k < $database`
    do
	jshon -e $name -e tag < $database
    done | sort | uniq 
}

# print all books
printbooks() {
    
    jshon -k < $database
}

# print all
#https://stackoverflow.com/questions/4409399/padding-characters-in-printf
printall() {
    padlength=$(
	for name in `jshon -k < pdffiledata.json`
	do
	    jshon -e $name -e tag < pdffiledata.json
	done | sort | uniq | wc -L  
	 )
    padlength=$((padlength+1))
    padmax=`jshon -k < $database | wc -L`
    padmax=$((padlength+padmax))
    echo $padmax
    pad=$(printf '%0.1s' " "{1..42})
    for name in `jshon -k < pdffiledata.json`
    do
	
	var1=`jshon -e $name -e tag < pdffiledata.json`
	printf "%s" "$var1"
	printf '%*.*s' 0 $((padlength - ${#var1} )) "$pad"
	printf "%s\n" "$name"
    done

}

printall

