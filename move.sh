#!/bin/bash

./cligol/cligol

weekday=`date +"%w"`
today=`date +%Y-%m-%d`
if (( weekday == 6 ))
then
  weekday=0
fi

first_col_date=$(date --date="${today} -${weekday} day -364 day" +%Y-%m-%d)

RANDOM=$(date +%s%N | cut -b10-19)
new_branch=branch-$today-$RANDOM

git checkout -b $new_branch

input="cligol/data/board.txt"
while read line || [ -n "$line" ]
do
  commit_date=$first_col_date
  for i in $line; do
    if [ $i -eq 1 ]
    then
      loop=0
      while (( loop < 30 ))
      do
        GIT_COMMITTER_DATE="$commit_date $((10 + RANDOM % 14)):$((10 + RANDOM % 49)):$((10 + RANDOM % 49))" git commit --date "$commit_date $((10 + RANDOM % 14)):$((10 + RANDOM % 49)):$((10 + RANDOM % 49))" -m "" --allow-empty --allow-empty-message --quiet
        ((loop++))
      done
    fi
    commit_date=$(date --date="${commit_date} +7 day" +%Y-%m-%d)
  done
  first_col_date=$(date --date="${first_col_date} +1 day" +%Y-%m-%d)
done < "$input"

git push origin $new_branch

curl -i -u "$USERNAME:$ACCESS_TOKEN" --header "Content-Type: application/json" --request PATCH --data "{\"name\": \"$REPOSITORY\", \"default_branch\": \"$new_branch\"}"  "https://api.github.com/repos/$USERNAME/$REPOSITORY"
