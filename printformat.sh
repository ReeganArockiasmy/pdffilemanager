#! /bin/bash

#database=pdffiledata.json
# print all tags
printtags(){
    
    for name in `jshon -k < $database`
    do
	jshon -e $name -e tag < $database | tr -d "[],"
    done | sort | uniq | sed '/^\s*$/d'
}

# print all books
printbooks() {
    
    jshon -k < $database
}

printline() {
    tag="tags"
    printf "%0.s-" echo `seq 1 $padmax`
    printf "\n"
    printf "%s" "$tag"
    printf '%*.*s' 0 $((padlength - ${#tag} )) "$pad"
    printf "%s\n" "Book Name"
    printf "%0.s-" echo `seq 1 $padmax`
    printf "\n"
    
}



# print all
#https://stackoverflow.com/questions/4409399/padding-characters-in-printf
printall() {
    padlength=$(
	for name in `jshon -k < $database`
	do
	    jshon -e $name -e tag < $database | tr -d "[],"
	done | sort | uniq | sed '/^\s*$/d' | wc -L  
	 )
    padlength=$((padlength+1))
    padmax=`jshon -k < $database | wc -L`
    padmax=$((padlength+padmax))
    pad=$(printf '%0.s ' $(seq 1 $padmax))
    printline
    for name in `jshon -k < $database`
    do
	
	var1=`jshon -e $name -e tag < $database | tr -d "[]," | sed '/^\s*$/d'`
	for i in $var1
	do
	    printf "%s" "$i"
	    printf '%*.*s' 0 $((padlength - ${#i} )) "$pad"
	    printf "%s\n" "$name"
	done
    done

}


