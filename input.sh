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

# make jshon command
cmd="jshon -Q -n {} -n {} -s $location -i location -s $tags -i tag -i $name"

#manipulate the jshon output
if [ ! -f $database ]
then
    echo -e "{" > $database
else
    sed -i '$d' $database
    echo "," >> $database
fi
# remove the first and last line
eval $cmd | sed -n '1!p' | sed '$d' >> $database
echo -e "}" >> $database
    




#_. Dummy outline topic header -- see ‘allout-mode’ docstring: ‘C-h m’.
#_. Local emacs vars.
#_ , Local variables:
#_ , allout-layout: (-1 : 0)
#_ , End:

