#!/bin/bash

#args
ALLOWEDTIME=${1:-600}
PRODUCTION=${2:-true}

#timer
STARTTIME=`date +%s`

# functions
doalarm() { perl -e 'alarm shift; exec @ARGV' "$@"; }
export -f doalarm

#Get the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Logging
LOGDIR="$DIR"/logs
TODAY=`date +%m.%d.%y`
TIME=`date +%m-%d-%YT%H:%M:%S%z`
mkdir -p "$LOGDIR"
exec > >(tee -a "$LOGDIR"/log_"$TODAY".txt) 2>&1

echo $HOSTNAME
echo $TODAY $TIME
echo Running as $(whoami)

cd "$DIR"
GIT=`which git`


#Check remaining time
CURRENTTIME=`date +%s`
RUNTIME=$((CURRENTTIME-STARTTIME))
REMAINTIME=$((ALLOWEDTIME-RUNTIME))
if [ "$REMAINTIME" -lt 0 ]; then
  #End the shell script
  echo Allowed runtime: $ALLOWEDTIME seconds passed. Stopping script.
  exit 130
fi

echo running the R script
# ********** ADD R SCRIPT HERE
/usr/local/bin/R < hello.r --no-save
# have it output it's results into this same directory tree

RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo R script succeeded.
else
  echo R script FAILED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
fi

#Check remaining time
CURRENTTIME=`date +%s`
RUNTIME=$((CURRENTTIME-STARTTIME))
REMAINTIME=$((ALLOWEDTIME-RUNTIME))
if [ "$REMAINTIME" -lt 0 ]; then
  #End the shell script
  echo Allowed runtime: $ALLOWEDTIME seconds passed. Stopping script.
  exit 130
fi

#remove log files older than 6mo
echo removing old log files
cd "logs"
find * -mtime +180 -delete
cd "$DIR"

if [ "$PRODUCTION" = true ]; then
  echo commiting any file changes to CRON R GIT repo
  #echo this step is important when logging files are committed to git
  ${GIT} add -A && ${GIT} commit -m "CRON R GIT job on $HOSTNAME, $TODAY"

  # Assumes that the remote is already set for this branch and RSA keys will work...
  echo pushing file changes within CRON R GIT repo
  ${GIT} push
fi

echo cron_run.sh completed run
printf "\n"
printf "\n"
