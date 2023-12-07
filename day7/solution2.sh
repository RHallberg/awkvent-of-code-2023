#!/bin/bash

awk -f solution2.awk input.txt | sort -n | awk 'BEGIN{sum=0}{sum+=$3*NR}END{print sum}'
