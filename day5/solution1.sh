#!/bin/bash

awk -f solution1.awk input.txt | sort -n -r | tail -1
