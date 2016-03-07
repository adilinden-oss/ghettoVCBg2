#!/bin/sh
#
# Execute our backup
#
# * May 9, 2014
# Modified to take advantage of my custom command line options.
# Now we can have multiple hosts files and a single script to
# execute.
#

myDryrun=0

myOddBackupDatastore="backup1.nfs1"
myEvenBackupDatastore="backup2.nfs1"

myDailyBackupDirectory="backup_daily"
myWeeklyBackupDirectory="backup_weekly"

myDailyBackupCount=2
myWeeklyBackupCount=2

# Misc args

myDir=`dirname $0`
myScript=ghettoVCBg2.pl

# Command line args

function usage {
    echo "Usage: do.sh {suffix} [reverse]"
    echo "    suffix       The suffix to append to the hosts file"
    echo "                 listing all VM to be backed up."
    echo "    reverse      Reverse the odd and even datastores."
    echo
    echo "Written by Adi Linden <adi@adis.on.ca>"
    echo
}

# What
mySuffix="$1"
myList="hosts.$mySuffix"
if [ ! -e "$myDir/$myList" ]; then
    echo "Missing VM list file."
    usage
    exit 1
fi

# Reversed
if [ "x$2" = "xreverse" ]; then
    myReverse="yes"
fi

# When
myDay=$(date +%j)
myWeek=$(date +%W)
myWeekday=$(date +%u)
myOddDay=$(expr $myDay % 2)
myOddWeek=$(expr $myWeek % 2)

if [ $myWeekday -eq 6 ]; then
    myWhen=weekly
    myBackupDirectory="$myWeeklyBackupDirectory"
    myBackupCount="$myWeeklyBackupCount"
    if [ "$myOddWeek" = "1" -a "x$myReverse" = "xyes" ] || [ "$myOddWeek" = "0" -a "x$myReverse" = "x" ]; then
        myBackupDatastore="$myEvenBackupDatastore"
    else
        myBackupDatastore="$myOddBackupDatastore"
    fi
else
    myWhen=daily
    myBackupDirectory="$myDailyBackupDirectory"
    myBackupCount="$myDailyBackupCount"
    if [ "$myOddDay" = "1" -a "x$myReverse" = "xyes" ] || [ "$myOddDay" = "0" -a "x$myReverse" = "x" ]; then
        myBackupDatastore="$myEvenBackupDatastore"
    else
        myBackupDatastore="$myOddBackupDatastore"
    fi
fi


# Build some more vars
myEmailSubject="VM Backup - ${mySuffix} - ${myWhen} - ${myBackupDatastore} -"
myLog="/tmp/ghettoVCBg2-${mySuffix}-${myWhen}-${myBackupDatastore}.log"

# Run backup script
[ -e "${myLog}" ] && rm -f ${myLog}
cd ${myDir}

${myDir}/${myScript} --config_dir configs --dryrun ${myDryrun} \
    --vmlist ${myList} --backup_datastore ${myBackupDatastore} \
    --backup_directory ${myBackupDirectory} \
    --backup_rotation ${myBackupCount} \
    --output ${myLog} --email_subject "${myEmailSubject}"

# End
