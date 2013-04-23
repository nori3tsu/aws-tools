#!/bin/bash

. /etc/profile.d/aws-apitools-common.sh
. /etc/sysconfig/aws.env

INSTANCE_NAME=$1
INSTANCE_ID=`ec2-instance-id-search.sh $INSTANCE_NAME`

usage() {
   echo $"Usage: $0 {instance_name} {start|stop|status}"
   exit 1
}

if [ -z ${INSTANCE_ID} ]; then
   usage
fi

start() {
   echo "Start: $INSTANCE_NAME, $INSTANCE_ID"
   ec2-start-instances $INSTANCE_ID
   return $?
}

stop() {
   echo "Stop: $INSTANCE_NAME, $INSTANCE_ID"
   ec2-stop-instances $INSTANCE_ID
   return $?
}

status() {
   local status=`ec2-describe-instances | grep INSTANCE | grep $INSTANCE_ID | cut -f6`
   echo "Status: $status"
   return $?
}

case "$2" in
   start)
      start
      ;;
   stop)
      stop
      ;;
   status)
      status
      ;;
   *)
      usage
      ;;
esac

exit $?