#!/bin/bash

### Script to validate team
TEAM_FILE="my_team.txt"
STEP="STEP 1 : MY TEAM"

EMAIL_PROF=guewen.faivre@elao.com
FROM_EMAIL=no-reply@elao.com

EMAIL=`cat $TEAM_FILE | grep -i mail | tr --delete ' ' | cut -d '=' -f 2`
TEAM_NAME=`cat $TEAM_FILE | grep -i name | tr --delete ' ' | cut -d '=' -f 2`
MOTTO=`cat $TEAM_FILE | grep -i motto | tr --delete ' ' | cut -d '=' -f 2`

HISTORY_NAME="history_step1"
HISTORY="${HOME}/.bash_history"

echo $EMAIL
echo $TEAM_NAME
echo $MOTTO

if [[ $EMAIL = "" || $TEAM_NAME = "" || $MOTTO = "" ]]
then
    echo -e "\e[31mFAIL\e[0m : Your file is not valid"
else
    echo -e "\e[92mSUCCESS\e[0m : Your file is ok, your team is now registered"
    echo $'Step 1 : OK\n'"User: $EMAIL"$'\n'"Team_Name: $TEAM_NAME"$'\n'"Motto: $MOTTO"$'\n' | mail -s "[$STEP][$TEAM_NAME]" -A $HISTORY -r $FROM_EMAIL $EMAIL_PROF
fi
