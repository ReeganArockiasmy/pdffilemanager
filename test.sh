#!/usr/bin/expect -f
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



set timeout -1
spawn ./input.sh
expect "name\r"
send -- "alan.pdf\r"
expect "location\r"
send -- "/home/visteon/flatfile/pdfmanager/\r"
# # expect "tags\r"
# # send -- "expect tag\r"
# send_user "What is your password "
# stty -echo
# expect_user -re "(.*)\n" {set PASS $expect_out(1,string)}
# send_user "\n"
# stty echo
stty -echo
send_user -- "tags "
expect_user -re "(.*)\n"
send_user "\n"
stty echo
set pass $expect_out(1,string)
send -- "$pass\r"
expect eof
