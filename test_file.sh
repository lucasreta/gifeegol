#!/bin/bash

./cligol/cligol

weekday=`date +"%w"`
today=`date +%Y-%m-%d`
if (( weekday == 6 ))
then
  weekday=0
fi

first_col_date=$(date --date="${today} -${weekday} day -364 day" +%Y-%m-%d)

input="cligol/data/board.txt"
while read line || [ -n "$line" ]
do
  commit_date=$first_col_date
  for i in $line; do
    if [ $i -eq 1 ]
    then
      echo "$i $commit_date"
    fi
    commit_date=$(date --date="${commit_date} +7 day" +%Y-%m-%d)
  done
  first_col_date=$(date --date="${first_col_date} +1 day" +%Y-%m-%d)
done < "$input"
