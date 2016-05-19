#!/bin/sh
## This is my custom script that used for stopping qmail at spamorez VMs.
## There's nothing wonderful, we just search for process to kill, after things
##are done we start qmail again
for i in `ps waux|grep sv|grep -v grep|awk '{print $2}'`; do kill -9 $i;done
sleep 3
qmailctl stop
sleep 5
for i in `ps waux|grep supervise|grep -v grep|awk '{print $2}'`; do kill -9 $i;done
for i in `ps waux|grep multilog|grep -v grep|awk '{print $2}'`; do kill -9 $i;done
for i in `ps waux|grep qmail|grep -v grep|awk '{print $2}'`; do kill -9 $i;done
echo 'I killed them all'
csh -cf '/command/svscanboot &'
sleep 3
qmailctl stat
tail /var/log/qmail/qmail-send/current 
date
