#!/bin/bash

### Script to validate players
STEP="STEP 3 : MY PLAYERS"

HISTORY_NAME="history_step3"
HISTORY="/tmp/$HISTORY_NAME"

EMAIL_PROF=j.marjollet@bh-technologies.com

TEAM_FILE="my_team.txt"
EMAIL=`cat $TEAM_FILE | grep -i mail | tr --delete ' ' | cut -d '=' -f 2`
TEAM_NAME=`cat $TEAM_FILE | grep -i name | tr --delete ' ' | cut -d '=' -f 2`
MOTTO=`cat $TEAM_FILE | grep -i motto | tr --delete ' ' | cut -d '=' -f 2`

PLAYERS_FOLDER="My_Players"
SPONSORS_FOLDER="My_Sponsors"

# Players level and cost check
echo -e "\e[92mYou have chosen these Players :\e[0m"
for PLAYERS in `ls -1 $PLAYERS_FOLDER/*.player | cut -d '/' -f 2`
do
    # Process players and print level + cost
    P_LEVEL=`cat $PLAYERS_FOLDER/$PLAYERS | grep LEVEL | cut -d '=' -f 2`
    P_COST=`cat $PLAYERS_FOLDER/$PLAYERS | grep VALUE | cut -d '=' -f 2`    
    TOTAL_LEVEL=$(($TOTAL_LEVEL + `cat $PLAYERS_FOLDER/$PLAYERS | grep LEVEL | cut -d '=' -f 2`))
    TOTAL_COST=$(($TOTAL_COST + `cat $PLAYERS_FOLDER/$PLAYERS | grep VALUE | cut -d '=' -f 2`))
    echo "$PLAYERS with level : $P_LEVEL and cost : $P_COST €" 
    NB_PLAYERS=$(($NB_PLAYERS + 1))
done


# Sponsors budget check
for SPONSOR in `ls -1 $SPONSORS_FOLDER/*.sponsor | cut -d '/' -f 2`
do
    TOTAL_BUDGET=$(($TOTAL_BUDGET + `cat $SPONSORS_FOLDER/$SPONSOR`))
    NB_SPONSORS=$(($NB_SPONSORS + 1))
done
echo -e "\n\e[92mYour total budget is: $TOTAL_BUDGET € \e[0m"


# Final validation
if [[ $NB_PLAYERS -lt 11 || $NB_PLAYERS -gt 15 ]]
then
    if [[ $NB_PLAYERS -le 0 ]]
    then
	echo -e "\n\e[31mFAIL\e[0m : No players found, you have to choose from 11 to 15 players !"
    else
	echo -e "\n\e[31mFAIL\e[0m : Invalid number of players, you have to choose from 11 to 15 players!"
    fi
    exit 1
fi

if [[ $TOTAL_COST -gt $TOTAL_BUDGET ]]
then
    echo -e "\n\e[31mFAIL\e[0m : Your players cost exceeded your total budget : $TOTAL_COST / $TOTAL_BUDGET"
else    
    echo -e "\n\e[92mSUCCESS\e[0m : Your total level is ""$TOTAL_LEVEL | Your players cost : $TOTAL_COST / $TOTAL_BUDGET"
    cp ~/.bash_history /tmp/$HISTORY_NAME
    echo $'Step 3 : OK\n'"User: $EMAIL"$'\n'"Team_Name: $TEAM_NAME"$'\n'"Motto: $MOTTO"$'\n' | mail -s "[$STEP][$TEAM_NAME]" -A $HISTORY $EMAIL_PROF
fi
