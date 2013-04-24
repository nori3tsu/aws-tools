#!/bin/bash

INSTANCE_NAME=${1:-NONE}

if [ $INSTANCE_NAME = "NONE" ]; then
  echo "Usage: $0 [instance_name]"
  exit 1
fi

. /etc/sysconfig/aws.env

ec2-describe-instances | grep TAG | grep $INSTANCE_NAME | cut -f3