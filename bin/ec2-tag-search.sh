#!/bin/bash

TAG_NAME=${1:-NONE}

if [ $TAG_NAME = "NONE" ]; then
  echo "Usage: $0 [tag_name]"
  exit 1
fi

. /etc/sysconfig/aws.env

ec2-describe-instances | grep $INSTANCE_ID | grep TAG | grep $TAG_NAME | cut -f5