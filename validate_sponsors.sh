#!/bin/bash

### Script to validate sponsors
STEP="STEP 2 : MY SPONSORS"

HISTORY_NAME="history_step2"
HISTORY="/tmp/$HISTORY_NAME"

EMAIL_PROF=ops@campus-numerique-in-the-alps.com
FROM_EMAIL=ops@campus-numerique-in-the-alps.com

TEAM_FILE="my_team.txt"
EMAIL=`cat $TEAM_FILE | grep -i mail | tr --delete ' ' | cut -d '=' -f 2`
TEAM_NAME=`cat $TEAM_FILE | grep -i name | tr --delete ' ' | cut -d '=' -f 2`
MOTTO=`cat $TEAM_FILE | grep -i motto | tr --delete ' ' | cut -d '=' -f 2`

SPONSORS_FOLDER="My_Sponsors"

echo -e "\e[92mYou have chosen these sponsors :\e[0m"
for SPONSOR in `ls -1 $SPONSORS_FOLDER/*.sponsor | cut -d '/' -f 2`
do
    echo `echo $SPONSOR | cut -d "." -f 1` ": " `cat $SPONSORS_FOLDER/$SPONSOR`
    TOTAL_BUDGET=$(($TOTAL_BUDGET + `cat $SPONSORS_FOLDER/$SPONSOR`))
    NB_SPONSORS=$(($NB_SPONSORS + 1))
done

if [[ $NB_SPONSORS -le 0 || $NB_SPONSORS -gt 20 ]]
then
    if [[ $NB_SPONSORS -le 0 ]]
    then
	echo -e "\n\e[31mFAIL\e[0m : No sponsor found, you have to choose from 1 to 3 sponsors !"
    else
	echo -e "\n\e[31mFAIL\e[0m : Invalid number of sponsors, you have to choose from 1 to 3 sponsors!"
    fi
else
    echo -e "\n\e[92mSUCCESS\e[0m : Your total budget is ""$TOTAL_BUDGET"
    cp ~/.bash_history /tmp/$HISTORY_NAME
    echo $'Step 2 : OK\n'"User: $EMAIL"$'\n'"Team_Name: $TEAM_NAME"$'\n'"Motto: $MOTTO"$'\n' | mail -s "[$STEP][$TEAM_NAME]" -A $HISTORY -r $FROM_EMAIL $EMAIL_PROF
fi
