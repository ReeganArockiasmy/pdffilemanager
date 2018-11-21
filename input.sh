#!/bin/sh
database=pdffiledata.json
keys=( name location tags )

# get user input

for key in "${keys[@]}"
do
    echo $key
    read value
    declare "${key}"=$value
done

#multipletag
tagcmd="[]"
for tag in $(echo $tags | tr "," "\n")
do
    tagcmd=$tagcmd" -s "$tag" -i 0"
done

# make jshon command
cmd="jshon -Q -n {} -n {} -s $location -i location -n $tagcmd -i tag -i $name"

#manipulate the jshon output
if [ ! -f $database ]
then
    echo -e "{" > $database
else
    sed -i '$d' $database
    echo "," >> $database
fi
# remove the first jshon output and redirect the file
eval $cmd | sed -n '1!p' >> $database
