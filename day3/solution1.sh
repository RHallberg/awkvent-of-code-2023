#!/bin/bash

cat input.txt | sed 's/[^.0-9]/S/g' > prepped_input.txt
awk -f solution1.awk prepped_input.txt prepped_input.txt
rm prepped_input.txt

