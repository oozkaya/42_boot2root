#!/bin/bash

charset=({0..6})
phase_1="Public speaking is very easy."
phase_2="1 2 6 24 120 720"
phase_3="0 q 777"
phase_4="9"
phase_5="opekma"

function permute(){
        (($1 == 0)) && { echo "$2"; return; }
        for char in "${charset[@]}"
        do
                permute "$((${1} - 1 ))" "$2 $char"
        done
}

#generate every combinations of the 6 integers
permute "6" > comb.txt
sed -i 's/^.//' comb.txt
echo "comb.txt generated"

#bruteforce
i=0
while IFS= read -r line
do
        if echo -e "$phase_1\n$phase_2\n$phase_3\n$phase_4\n$phase_5\n$line" | ./bomb | grep -q "Cong"; then
                echo "phase_6=$line";
                exit 0
        fi
        if (($i % 1000 == 0));then
                echo "$i"
        fi
        ((i=i+1))
done < comb.txt
