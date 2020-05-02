#!/bin/bash
# Developed by Gudiwada Ram Prasad
# Shell script to monitor disk space in the machine
USER=$LOGNAME
echo "user name : $USER"
echo "user name : $LOGNAME"
# fill in these two vars as you like
MEM_THRESHOLD=85
TEAM_CLIENTS="/home/ram914/Desktop/scripts/USERS"

# read how much space is used and how much is left
spaceUsed=$(df -h| grep "/home$" | awk '{print $5}')
spaceLeft=$(df -h| grep "/home$" | awk '{print $4}')
spaceUsed=${spaceUsed%%%*}

/bin/echo "spaceUsed% : $spaceUsed"
/bin/echo "spaceLeft  : $spaceLeft"

# Function to send the mail
function sendMailTo() {
    name=$1
    toAddr=$2

    sub="WARNING: Disk Space Running out in $USER's Machine"
    content="Hi $name,\nThis mail is to warn you that the disk space in $USER's system is exceeded beyond the limit.\n
            The space left in his machine is just $spaceLeft.\n
            So, Please delete any unnecessary stuff that you have on $USER's machine.\n\n
            \n**** THIS MAIL IS AUTO GENERATED. DO NOT REPLY ****\n"

    /bin/echo -e $content|/usr/bin/mail -s "$sub" $toAddr
    return $?
}

# Check if the space used is more than the threshold value
if [ $spaceUsed -gt $MEM_THRESHOLD ];
then
    /bin/echo "Limit Crossed. need to alarm the users"

    # Get the clients from clients file and map them to users array
    #/bin/echo "clients path : $TEAM_CLIENTS"
    mapfile -t users < $TEAM_CLIENTS
    for client in "${users[@]}"
    do
        # skip all the comment lines and for the un-commented lines
        # in the $TEAM_CLIENTS, send the mail
        if [[ ! $client = \#* ]]
        then
            sendMailTo $client
            /bin/echo "Return val : $?"
        fi
    done
fi

### Example format for $TEAM_CLIENTS file ###
# ram   ram@xyzmail.com
# sita  sita@xyzmail.com
# #ravn ravn@xyzmail.com
### Above file, ravn is commented, so he won't receive mail
