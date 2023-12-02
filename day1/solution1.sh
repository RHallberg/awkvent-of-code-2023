#!/bin/bash

cat input.txt | sed 's/[[:alpha:]]//g' | sed 's/\([0-9]\)/\1 /g' | awk '{print $1 $NF}' | awk 'BEGIN {sum = 0} {sum += $1} END {print sum}'
