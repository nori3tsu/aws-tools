#!/bin/bash

CURRENT_DIR=`dirname $0`
cd $CURRENT_DIR

echo スクリプトに実行権限を付与
/bin/chmod u+x bin/*
/bin/chmod u+x service/*

echo サービスを配置
\cp -vf service/* /etc/init.d/

echo 設定ファイルを配置
\cp -vf config/* /etc/sysconfig/
\cp -vf home/{.*,*} /root/ 2>/dev/null
/bin/chmod 600 /root/.aws-secrets
if [ `grep "aws.env" /root/.bashrc | wc -l` -eq 0 ]; then
        echo ". /etc/sysconfig/aws.env" >> /root/.bashrc
fi

echo Route53操作スクリプトをダウンロード
mkdir -p extra/r53/bin
cd extra/r53/bin

/usr/bin/curl -LO http://awsmedia.s3.amazonaws.com/catalog/attachments/dnscurl.pl
/bin/chmod u+x dnscurl.pl


cat << EOT
================================================
初期設定:
1. キーを設定
# vim /etc/sysconfig/aws.env
~
export AWS_ACCESS_KEY=XXX
export AWS_SECRET_KEY=XXX
~
================================================
EOT

echo 完了!!