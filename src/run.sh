#!/bin/bash

echo "Running container"

REQUIRED_ENV=(
  "BAKS3S3_CRON_TIME"
  "BAKS3S3_SRC_KEY"
  "BAKS3S3_SRC_SECRET"
  "BAKS3S3_SRC_ENDPOINT"
  "BAKS3S3_SRC_REGION"
  "BAKS3S3_SRC_BUCKET"
  "BAKS3S3_TARGET_KEY"
  "BAKS3S3_TARGET_SECRET"
  "BAKS3S3_TARGET_ENDPOINT"
  "BAKS3S3_TARGET_REGION"
  "BAKS3S3_TARGET_BUCKET"
)
for name in "${REQUIRED_ENV[@]}"; do
  if [ -z "${!name}" ]; then
    echo "FAIL: please specify ${name} env variable" && exit 1
  fi
done

echo "
[source]
type = s3
provider = Other
env_auth = false
access_key_id = ${BAKS3S3_SRC_KEY}
secret_access_key = ${BAKS3S3_SRC_SECRET}
region = ${BAKS3S3_SRC_REGION}
endpoint = ${BAKS3S3_SRC_ENDPOINT}
" >/root/.config/rclone/rclone.conf

echo "
[target]
type = s3
provider = Other
env_auth = false
access_key_id = ${BAKS3S3_TARGET_KEY}
secret_access_key = ${BAKS3S3_TARGET_SECRET}
region = ${BAKS3S3_TARGET_REGION}
endpoint = ${BAKS3S3_TARGET_ENDPOINT}
" >>/root/.config/rclone/rclone.conf

service cron start

env >>/etc/environment

LOG_FILE="/root/logs/log.txt"

echo "
${BAKS3S3_CRON_TIME} /root/backup.sh >> ${LOG_FILE} 2>&1
" >/root/crontab.conf

crontab /root/crontab.conf

source /root/backup.sh >> ${LOG_FILE} 2>&1

tail -f /dev/null
