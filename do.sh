#!/bin/sh
#
# Execute our backup
#
# * April 15, 2012
# Modified to utilize alternate backup locations
#

myOddDaySub="Daily Odd Backup"
myOddDayDS="backup.store1"
myOddDayDir="daily_odd"
myOddDayCnt="2"
myEvenDaySub="Daily Even Backup"
myEvenDayDS="backup.store2"
myEvenDayDir="daily_even"
myEvenDayCnt="2"

myOddWeekSub="Weekly Odd Backup"
myOddWeekDS="backup.store1"
myOddWeekDir="weekly_odd"
myOddWeekCnt="3"
myEvenWeekSub="Weekly Even Backup"
myEvenWeekDS="backup.store2"
myEvenWeekDir="weekly_even"
myEvenWeekCnt="3"

myPath=/home/vi-admin/ghettoVCBg2
myScript="ghettoVCBg2.pl"
myLog="/tmp/ghettoVCBg2.log"
#myArgs="--dryrun 0 --config_dir configs --vmlist hosts --output ${myLog}"
myArgs="--dryrun 0 --config_dir configs --vmlist hosts.debug --output ${myLog}"

function prep {
    # Wipe log file
    > ${myLog}

    # Change working directory
    cd ${myPath}
}

# Determine odd or even week
WK=`date +%W`
ODD_WK=`expr $WK % 2`

# Determine odd or even day
DY=`date +%j`
ODD_DY=`expr $DY % 2`

# Execute backup
case "$1" in
    "daily")
        prep
        if [ $ODD_DY = 1 ]; then
            ${myPath}/${myScript} ${myArgs} \
                --backup_datastore "${myOddDayDS}" \
                --backup_directory "${myOddDayDir}" \
                --backup_rotation ${myOddDayCnt} \
                --email_subject "${myOddDaySub}"
        else
            ${myPath}/${myScript} ${myArgs} \
                --backup_datastore "${myEvenDayDS}" \
                --backup_directory "${myEvenDayDir}" \
                --backup_rotation ${myEvenDayCnt} \
                --email_subject "${myEvenDaySub}"
        fi
        ;;
    "weekly")
        prep
        if [ $ODD_WK = 1 ]; then
            ${myPath}/${myScript} ${myArgs} \
                --backup_datastore "${myOddWeekDS}" \
                --backup_directory "${myOddWeekDir}" \
                --backup_rotation ${myOddWeekCnt} \
                --email_subject "${myOddWeekSub}"
        else
            ${myPath}/${myScript} ${myArgs} \
                --backup_datastore "${myEvenWeekDS}" \
                --backup_directory "${myEvenWeekDir}" \
                --backup_rotation ${myEvenWeekCnt} \
                --email_subject "${myEvenWeekSub}"
        fi
        ;;
    *)
        echo $"Usage: $0 {daily|weekly}"
        exit 1
        ;;
esac

