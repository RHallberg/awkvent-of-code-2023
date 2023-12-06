#!/bin/bash

cat input.txt | sed -E 's/Card +[0-9]+: //g' | awk -f solution2.awk
