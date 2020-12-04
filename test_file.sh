#!/bin/bash

./cligol/cligol

input="cligol/data/board.txt"
while IFS= read -r line
do
  IFS=' '
  read -ra ADDR <<< "$line"
  for i in "${ADDR[@]}"; do
    echo "$i"
  done
done < "$input"
