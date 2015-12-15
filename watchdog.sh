#!/bin/bash

# mail file format:
# success:
# To:
# Subject: Watchdog Run Completed. Woof.
# From:
#
# failure:
# To: 
# Subject: Watchdog Killed PROCESS_NAME. Woof.
# From: 

# time in seconds
SIX_HOURS=21600
FORTY_FIVE_MINUTES=2700
THIRTY_MINUTES=1800

ROOT=/home/scott
LOG=$ROOT/logs/watchdog.txt
SRCDIR=/home/scott/watchdog


function KilledProcess {
  cat $SRCDIR/mail_killed.txt $LOG | sed s/PROCESS_NAME/$1/ | /usr/sbin/sendmail -t
}


function Success {
  cat $SRCDIR/mail.txt $LOG | /usr/sbin/sendmail -t
}


function CheckPID {
  # starttime in epochmillis
  init=`stat -t /proc/$1 | awk '{print $14}'`
  # current time in epochmillis
  curr=`date +%s`
  # process elapsed time in seconds
  runtime=`echo $curr - $init| bc`

  name=`ps -p $1 -o comm=`
  echo "Found $name, runtime $runtime seconds" >> $LOG

  if [ $runtime -gt $2 ]; then
    echo "Killing longrunning process: $name, pid: $1, runtime: $runtime seconds" >> $LOG
    kill $1
    KilledProcess $name
    break
  fi
}


echo "Backing up log"
cp $LOG "$LOG.bak"

rm -rf $LOG # new log for this run
echo "BEGIN Watchdog." >> $LOG;
date >> $LOG;
echo "" >> $LOG;

echo "Checking PROCESS_NAME" >> $LOG
pidlist=`ps ax | grep "PROCESS_NAME\." | grep -v grep | awk '{print $1}'`
for pid in $pidlist; do
  CheckPID $pid $FORTY_FIVE_MINUTES
done

echo "" >> $LOG;
echo "" >> $LOG
echo "END Watchdog" >> $LOG
date >> $LOG
echo "" >> $LOG

Success

