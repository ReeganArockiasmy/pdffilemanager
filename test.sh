#!/bin/bash


# list of tags

# for name in `jshon -k < pdffiledata.json`
# do
# jshon -e $name -e tag < pdffiledata.json
# done | sort | uniq 


# list of books
#jshon -k < pdffiledata.json


#table of json

space=$(
    for name in `jshon -k < pdffiledata.json`
    do
	jshon -e $name -e tag < pdffiledata.json
    done | sort | uniq | wc -L  
     )

echo $space

pad=$(printf '%0.1s' " "{1..33})
padlength=10
for name in `jshon -k < pdffiledata.json`
do

    var1=`jshon -e $name -e tag < pdffiledata.json`
    printf "%s" "$var1"
    printf '%*.*s' 0 $((padlength - ${#var1} )) "$pad"
    printf "%s\n" "$name"
done


# pad=$(printf '%0.1s' "-"{1..60})
# padlength=40
# string2='bbbbbbb'
# for string1 in a aa aaaa aaaaaaaa
# do
#      printf '%s' "$string1"
#      printf '%*.*s' 0 $((padlength )) "$pad"
#      printf '%s\n' "$string2"
#     # string2=${string2:1}
# done
       


# cmd="find $PWD -type d \( "
# grepcmd=""
# for igndir in `cat ignoredir.txt`
# do
# if [[ $igndir == *pdf ]]
# then
# grepcmd=$grepcmd"| grep -v "$igndir
# else
# cmd=$cmd$"-path "$igndir" -o "
# fi
# done
# echo $grepcmd
# cmd=${cmd::-3}
# cmd=$cmd"\) -prune -o -name \"*.pdf\"  -print"
# echo $cmd$grepcmd
# eval $cmd$grepcmd


# echo "==============================================="
# echo "1.0pen  2.Next(or Enter) 3.Open Page inShell "
# echo "q-quit"
# echo "==============================================="

# #read -p  "#? " option

# select var in open next inshell quit
# do
#     case $var in
# 	open|1 )
	    
# 	    ;;
# 	next|2) 
# 	    echo "next do"
# 	    ;;
# 	inshell|3 )
# 	    echo "inshell"
# 	    ;;
# 	quit|q )
# 	    break
# 	    ;;
# 	*)
# 	    echo "anything"
# 	    ;;
#     esac
#     done

# myexit(){

#    echo "testing"
# }
# trap myexit 0

# echo "testted"



# set timeout -1
# spawn ./input.sh
# expect "name\r"
# send -- "alan.pdf\r"
# expect "location\r"
# send -- "/home/visteon/flatfile/pdfmanager/\r"
# # # expect "tags\r"
# # # send -- "expect tag\r"
# # send_user "What is your password "
# # stty -echo
# # expect_user -re "(.*)\n" {set PASS $expect_out(1,string)}
# # send_user "\n"
# # stty echo
# stty -echo
# send_user -- "tags "
# expect_user -re "(.*)\n"
# send_user "\n"
# stty echo
# set pass $expect_out(1,string)
# send -- "$pass\r"
# expect eof
