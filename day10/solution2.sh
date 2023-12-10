#!/bin/bash

echo $[$(awk -f expander.awk input.txt | awk -f solution.awk | grep "*" -o | wc -l)/3]
