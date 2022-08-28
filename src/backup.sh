#!/bin/bash

SRC_PATH="source:${BAKS3S3_SRC_BUCKET}/${BAKS3S3_SRC_DIR}"
TARGET_PATH="target:${BAKS3S3_TARGET_BUCKET}/${BAKS3S3_TARGET_DIR}"

echo "$(date "+%Y-%m-%d %H:%M") - SYNC FROM ${SRC_PATH} TO ${TARGET_PATH}"
rclone sync "${SRC_PATH}" "${TARGET_PATH}"
