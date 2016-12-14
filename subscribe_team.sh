#!/bin/bash

### Script to validate team
TEAM_FILE="my_team.txt"
STEP="STEP 1 : MY TEAM"

EMAIL_PROF=ops@campus-numerique-in-the-alps.com
FROM_EMAIL=ops@campus-numerique-in-the-alps.com

EMAIL=`cat $TEAM_FILE | grep -i mail | tr --delete ' ' | cut -d '=' -f 2`
TEAM_NAME=`cat $TEAM_FILE | grep -i name | tr --delete ' ' | cut -d '=' -f 2`
MOTTO=`cat $TEAM_FILE | grep -i motto | tr --delete ' ' | cut -d '=' -f 2`

HISTORY_NAME="history_step1"
HISTORY="/tmp/$HISTORY_NAME"

echo $EMAIL
echo $TEAM_NAME
echo $MOTTO


if [[ $EMAIL = "" || $TEAM_NAME = "" || $MOTTO = "" ]]
then
    echo -e "\e[31mFAIL\e[0m : Your file is not valid"
else
    echo -e "\e[92mSUCCESS\e[0m : Your file is ok, your team is now registered"
    cp ~/.bash_history /tmp/$HISTORY_NAME
    echo $'Step 1 : OK\n'"User: $EMAIL"$'\n'"Team_Name: $TEAM_NAME"$'\n'"Motto: $MOTTO"$'\n' | mail -s "[$STEP][$TEAM_NAME]" -A $HISTORY -r $FROM_EMAIL $EMAIL_PROF
fi
