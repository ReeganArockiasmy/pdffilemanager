#!/bin/sh
keys=( name location tags priroity )

# get user input

for key in "${keys[@]}"
do
    echo $key
    read value
    declare "${key}"=$value
done

# make jshon command
# simple
cmd="jshon -n {}"
for key in "${keys[@]}"
do
     cmd=$cmd" -s "${!key}" -i "$key
done

eval $cmd
