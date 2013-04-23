#!/bin/bash

ROOT_DIR=`dirname $0`
AWS_TOOLS_CONF=/etc/sysconfig/aws.env

export PATH=$PATH:/bin:/sbin

SERVICE_NAME=$1
if [ ! -f $ROOT_DIR/service/$SERVICE_NAME ]; then
        echo "サービス$1は存在しません。"
        exit 1
fi

if [ ! -f $AWS_TOOLS_CONF ]; then
        echo "create file: ROOT_DIR/config/aws.env" ;
        cp $ROOT_DIR/config/aws.env $AWS_TOOLS_CONF
fi

echo "add service: $SERVICE_NAME"
chkconfig --add $SERVICE_NAME
chkconfig $SERVICE_NAME on

echo "SUCCESS!"
