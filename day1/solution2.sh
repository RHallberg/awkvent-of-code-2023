#!/bin/bash

cat input.txt | sed 's/one/one1one/g;s/two/two2two/g;s/three/three3three/g;s/four/four4four/g;s/five/five5five/g;s/six/six6six/g;s/seven/seven7seven/g;s/eight/eight8eight/g;s/nine/nine9nine/g' \
| sed 's/[[:alpha:]]//g' | sed 's/\([0-9]\)/\1 /g' | awk '{print $1 $NF}' | awk 'BEGIN {sum = 0} {sum += $1} END {print sum}'

