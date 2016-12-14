#!/bin/bash

### Script to validate players
STEP="STEP 5 : EUROPEAN COMPETITION"

HISTORY_NAME="history_step5"
HISTORY="/tmp/$HISTORY_NAME"

EMAIL_PROF=ops@campus-numerique-in-the-alps.com
FROM_EMAIL=ops@campus-numerique-in-the-alps.com

TEAM_FILE="my_team.txt"
EMAIL=`cat $TEAM_FILE | grep -i mail | tr --delete ' ' | cut -d '=' -f 2`
TEAM_NAME=`cat $TEAM_FILE | grep -i name | tr --delete ' ' | cut -d '=' -f 2`
MOTTO=`cat $TEAM_FILE | grep -i motto | tr --delete ' ' | cut -d '=' -f 2`

SPONSORS_FOLDER="My_Sponsors"
COMPETITION_FOLDER="European_Competition"

PLAYERS_FOLDER="European_Competition/My_Team"

if [[ -d $PLAYERS_FOLDER ]]
then
    echo -e "\n\e[92mOK:\e[0m Your Team is ready "
else
    echo -e "\n\e[31mFAIL\e[0m Your team is not ready for the local competition"	
fi

# Players level and cost check
NB_PLAYERS=0
for PLAYERS in `ls -1 $PLAYERS_FOLDER/*.player | cut -d '/' -f 3`
do
    # Process players and print level + cost
    P_LEVEL=`cat $PLAYERS_FOLDER/$PLAYERS | grep LEVEL | cut -d '=' -f 2`
    P_COST=`cat $PLAYERS_FOLDER/$PLAYERS | grep VALUE | cut -d '=' -f 2`    
    TOTAL_LEVEL=$(($TOTAL_LEVEL + `cat $PLAYERS_FOLDER/$PLAYERS | grep LEVEL | cut -d '=' -f 2`))
    TOTAL_COST=$(($TOTAL_COST + `cat $PLAYERS_FOLDER/$PLAYERS | grep VALUE | cut -d '=' -f 2`))
    NB_PLAYERS=$(($NB_PLAYERS + 1))
done

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

# Sponsors budget check
for SPONSOR in `ls -1 $SPONSORS_FOLDER/*.sponsor | cut -d '/' -f 2`
do
    TOTAL_BUDGET=$(($TOTAL_BUDGET + `cat $SPONSORS_FOLDER/$SPONSOR`))
    NB_SPONSORS=$(($NB_SPONSORS + 1))
done

# Sorts Teams by level

#sort -t _ -k 2 -g data.file
TMP_SORT_FILE="/tmp/team_sort2.txt"

function print_team_level {
    TOTAL_LEVEL=0
    for PLAYERS in `ls -1 $1/*.player | cut -d '/' -f 3`
    do
	# Process players and print level + cost
	P_LEVEL=`cat $1/$PLAYERS | grep LEVEL | cut -d '=' -f 2`
	TOTAL_LEVEL=$(($TOTAL_LEVEL + `cat $1/$PLAYERS | grep LEVEL | cut -d '=' -f 2`))
    done
    echo "$1""=""$TOTAL_LEVEL"
}

rm -f $TMP_SORT_FILE

for i in `ls -1 $COMPETITION_FOLDER`
do
    print_team_level "$COMPETITION_FOLDER/$i" >> $TMP_SORT_FILE
done

# Print results
RESULTS=`sort -t '=' -k 2nr -g $TMP_SORT_FILE`
echo -e "\n\e[44PREDICTIVE RESULTS:\e[0m"
echo "$RESULTS" > $TMP_SORT_FILE
cat --number $TMP_SORT_FILE | tr -s ' ' | sed 's|\t| |g' | sed 's|/| |g' | cut -d ' ' -f 2,4

if [[ `echo "$RESULTS" | head -n 1 | grep "My_Team"` = "" ]]
then
    echo -e "\n\e[31mFAIL\e[0m : If you go to the competition like this you will loose"
    while true; do
	echo ""
	read -p "Now, you can try to pay the referee, do you want to pay the referee ? [n/y]" ANSWER
	case $ANSWER in
	    [Yy]* ) echo "################" ;  echo -e "\e[31mGameOver, The police will put you in jail\e[0m" ; echo -e "\e[31mYou can restart the step or the game to win the competition !\e[0m" ; echo "################" ; exit 1;;

	    [Nn]* )
	    	echo "################" ; echo -e "\e[31mGameOver, You have lost the competition\e[0m" ;
	    	echo -e "\e[31mYou can restart the step or the game to win the competition !\e[0m" ; echo "################" ;
	    	echo $'Step 5 : FAIL\n'"User: $EMAIL"$'\n'"Team_Name: $TEAM_NAME"$'\n'"Motto: $MOTTO"$'\n' | mail -s "[$STEP][$TEAM_NAME]" -A $HISTORY -r $FROM_EMAIL $EMAIL_PROF
	    	exit 1 ;;

	    * ) echo "Please answer Yes (Y) or No (N)" ;;
	esac
    done
else
    echo -e "\n\e[92mSUCCESS\e[0m : You won the competition !"
    cp ~/.bash_history /tmp/$HISTORY_NAME
    echo $'Step 5 : OK\n'"User: $EMAIL"$'\n'"Team_Name: $TEAM_NAME"$'\n'"Motto: $MOTTO"$'\n' | mail -s "[$STEP][$TEAM_NAME]" -A $HISTORY -r $FROM_EMAIL $EMAIL_PROF
fi    
