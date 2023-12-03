#!/bin/bash
cat input.txt | sed 's/\*/S/g' | awk '{printf(".%s.\n",$0)}' > prepped_input.txt
awk -f solution2.awk prepped_input.txt prepped_input.txt | awk 'BEGIN {sum=0} NF == 2 {sum+= $1*$2} END{print sum}'
rm prepped_input.txt
