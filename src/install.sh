#!/bin/bash

ln -snf "/usr/share/zoneinfo/$BAKPGS3_TIMEZONE" /etc/localtime
echo "$BAKS3S3_TIMEZONE" >/etc/timezone

apt-get update
apt-get install -y \
	cron \
	unzip \
	curl

curl https://rclone.org/install.sh | bash

mkdir -p /root/.config/rclone/
mkdir -p /root/logs
touch /root/logs/log.txt
