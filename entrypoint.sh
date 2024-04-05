#!/bin/bash

# 检查环境变量CRON_SCHEDULE是否设置，如果没有设置，则默认不运行定时任务
CRON_SCHEDULE=${CRON_SCHEDULE:-""}

# 检查环境变量RCLONE_COMMAND是否设置，如果没有设置，则使用默认命令
RCLONE_COMMAND=${RCLONE_COMMAND:-"rclone version"}

# 如果CRON_SCHEDULE不为空，则将传入的命令写入crontab文件
if [ -n "${CRON_SCHEDULE}" ]; then
  echo "${CRON_SCHEDULE} /usr/bin/rclone --config /config/rclone.conf ${RCLONE_COMMAND}" > /etc/crontabs/root
  echo "Cron job scheduled: ${CRON_SCHEDULE}"
else
  echo "No cron job scheduled. To schedule a job, set the CRON_SCHEDULE environment variable."
fi

# 如果环境变量RUN_NOW设置为true，立即执行一次rclone命令
if [ "${RUN_NOW}" = "true" ]; then
  echo "Running rclone command now..."
  /usr/bin/rclone --config /config/rclone.conf ${RCLONE_COMMAND}
fi

# 启动crond服务
echo "Starting cron..."
crond -l 2 -f
