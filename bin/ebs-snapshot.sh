#!/bin/bash
set -e

. /etc/sysconfig/aws.env

### config
EBS_VOLUMES=
SAVE_GENERATION=
###

LOG=$AWS_TOOLS_LOG_DIR/ebs-snapshot.log

[ -d $AWS_TOOLS_LOG_DIR ] || mkdir -p $AWS_TOOLS_LOG_DIR

date > $LOG

for EBS_VOLUME in $EBS_VOLUMES; do
        desc="Creating a snapshot for $EBS_VOLUME" >> $LOG
        /opt/aws/bin/ec2-create-snapshot $EBS_VOLUME -d "$desc" >> $LOG 2>&1
done

for EBS_VOLUME in $EBS_VOLUMES; do
        SNAPSHOTS=`ec2-describe-snapshots | grep $EBS_VOLUME | sort -k5 -r | awk '{print $2}'` >> $LOG 2>&1
        GENERATION_COUNT=1
        for SNAPSHOT in $SNAPSHOTS; do
                if [ $GENERATION_COUNT -gt $SAVE_GENERATION ]; then
                        echo "Deleting a old snapshot $SNAPSHOT for $EBS_VOLUME" >> $LOG
                        /opt/aws/bin/ec2-delete-snapshot $SNAPSHOT >> $LOG 2>&1
                fi
                GENERATION_COUNT=`expr $GENERATION_COUNT + 1`
        done
done