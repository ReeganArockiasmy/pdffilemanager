#!/bin/bash

#make find cmd like a

#find /home/visteon -path /home/visteon/Downloads/package/emacs-25.3 -prune -o -path /home/visteon/Downloads/package/pycharm-community-2018.1.1/help -prune -o -name \*.pdf -print 2>/dev/null

findcmd="find $HOME "
for i in `cat ignoredir.txt`
do
    findcmd=$findcmd"-path $i -prune -o "
done
findcmd=$findcmd"-name \\*.pdf -print 2>/dev/null"

for i in `eval $findcmd`
do
    echo $i
done



# find $HOME \
#      -path /home/visteon/Downloads/package/emacs-25.3 -prune -o \
#      -path /home/visteon/Downloads/package/pycharm-community-2018.1.1 -prune -o\
#      -name \*.pdf -print 2>/dev/null
