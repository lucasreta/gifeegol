#!/bin/bash

weekday=`date +"%w"`
today=`date +%Y-%m-%d`
if (( weekday == 6 ))
then
  weekday=0
fi

day=$(date --date="${today} -${weekday} day -364 day" +%d)
month=$(date --date="${today} -${weekday} day -364 day" +%m)
year=$(date --date="${today} -${weekday} day -364 day" +%Y)

present_day=$(date --date="${today} -${weekday} day" +%d)
present_month=$(date --date="${today} -${weekday} day" +%m)
present_year=$(date --date="${today} -${weekday} day" +%Y)

echo Current Date is: ${present_year}-${present_month}-${present_day}
echo Initial Date is: ${year}-${month}-${day}

: '
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
  echo "20$year-$month-$day"
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
'
