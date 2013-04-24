#!/bin/bash

ROOT_DIR=`dirname $0`

export PATH=$PATH:/bin:/sbin

SERVICE_NAME=$1
if [ ! -f $ROOT_DIR/service/$SERVICE_NAME ]; then
        echo "サービス$1は存在しません。"
        exit 1
fi

echo "add service: $SERVICE_NAME"
chkconfig --add $SERVICE_NAME
chkconfig $SERVICE_NAME on

echo "SUCCESS!"
