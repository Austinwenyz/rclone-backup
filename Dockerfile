# 使用官方的Alpine Linux作为基础镜像，因为它非常轻量级
FROM alpine:latest

# 安装rclone和bash
RUN apk --no-cache add rclone bash

# 创建一个目录用于存放外部挂载的配置文件
RUN mkdir /config
VOLUME ["/config"]

# 复制启动脚本到容器
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 设置容器启动时执行的命令
ENTRYPOINT ["/entrypoint.sh"]
