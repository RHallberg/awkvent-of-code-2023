#!/bin/bash

awk -f expander.awk input.txt | awk -f solution.awk
