#!/bin/bash
declare -A fullnumbers=( [1]="01" [2]="02" [3]="03" [4]="04" [5]="05" [6]="06" [7]="07" [8]="08" [9]="09" )

weekday=`date +"%w"`
today=`date +%Y-%m-%d`
if (( weekday == 6 ))
then
  weekday=0
fi

day_number=$(( 10#$(date --date="${today} -${weekday} day -364 day" +%d) ))
month_number=$(( 10#$(date --date="${today} -${weekday} day -364 day" +%m) ))
year=$(date --date="${today} -${weekday} day -364 day" +%Y)

present_day=$(date --date="${today} -${weekday} day" +%d)
present_month=$(date --date="${today} -${weekday} day" +%m)
present_year=$(date --date="${today} -${weekday} day" +%Y)

if [ $month_number -le 9 ]
then
  month="${fullnumbers[$month_number]}"
else
  month="$month_number"
fi
if [ $day_number -le 9 ]
then
  day="${fullnumbers[$day_number]}"
else
  day="$day_number"
fi

past_days=true

while [ "$past_days" = true ]
do
  if (( month_number <= 9 ))
  then
    month="${fullnumbers[$month_number]}"
  else
    month="$month_number"
  fi
  if (( day_number <= 9 ))
  then
    day="${fullnumbers[$day_number]}"
  else
    day="$day_number"
  fi
  loop=0
  while (( loop <= 50 ))
  do
    GIT_COMMITTER_DATE="$year-$month-$day $((10 + RANDOM % 14)):$((10 + RANDOM % 49)):$((10 + RANDOM % 49))" git commit --date "$year-$month-$day $((10 + RANDOM % 14)):$((10 + RANDOM % 49)):$((10 + RANDOM % 49))" --allow-empty --allow-empty-message --quiet
    ((loop++))
  done

  day_number=$(( $day_number + 1 ))
  if [ "$month_number" == 10 ] || [ "$month_number" == 1 ] || [ "$month_number" == 3 ] || [ "$month_number" == 5 ] || [ "$month_number" == 7 ] || [ "$month_number" == 8 ]
  then
    if [ "$day_number" -ge 32 ]
    then
      day_number=1
      month_number=$(( $month_number + 1 ))
    fi
  elif [ "$month_number" -ge 12 ]
  then
    if [ "$day_number" -ge 32 ]
    then
      day_number=1
      month_number=1
      year=$(( $year + 1 ))
    fi
  elif [ "$month_number" == 2 ]
  then
    if [ "$day_number" -ge 29 ]
    then
      day_number=1
      month_number=$(( $month_number + 1 ))
    fi
  else
    if [ "$day_number" -ge 31 ]
    then
      day_number=1
      month_number=$(( $month_number + 1 ))
    fi
  fi
  if [ "$day_number" -ge "$present_day" ] && [ "$month_number" -ge "$present_month" ] && [ "$year" -ge "$present_year" ]
  then
    past_days=false
  fi
done

