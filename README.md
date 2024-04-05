> Github: https://github.com/Austinwenyz/rclone-backup/
> Docker Hub: https://hub.docker.com/r/austinwenyz/rclone-backup/

# Rclone Backup Docker

This is a lightweight Docker image based on Alpine Linux, designed for file backup and synchronization using Rclone. It supports scheduled tasks and immediate execution, allowing easy backup of local files to various cloud storage services.

## Features

- Based on Alpine Linux, the image has a small size and low resource consumption.
- Pre-installed with Rclone, supporting multiple cloud storage services.
- Supports scheduled tasks to automatically run backups at specified times.
- Supports immediate execution to perform a backup once when the container starts.
- Customizable Rclone commands and scheduled task times through environment variables.
- Logging functionality for easy monitoring of backup status and issue troubleshooting.

## Usage

1. Create a file named `docker-compose.yml` with the following content:

```yaml
version: '3'

services:
  rclone-backup:
    image: austinwenyz/rclone-backup:latest
    container_name: rclone-backup
    restart: always
    volumes:
      - ${dataPath}:/data
      - ${configPath}:/config/rclone.conf
    environment:
      - CRON_SCHEDULE=0 3 * * *
      - RCLONE_COMMAND=ls /data/config --progress
      - RUN_NOW=true
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
        
  rclone-backupMore:
    image: austinwenyz/rclone-backup:latest
    container_name: rclone-backupMore
    restart: always
    volumes:
      - ${dataPath}:/data
      - ${configPath}:/config/rclone.conf
    environment:
      - CRON_SCHEDULE=0 3 * * *
      - RCLONE_COMMAND=ls 123Pan:/SYNC/ --progress
      - RUN_NOW=true
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

2. Replace `${dataPath}` with the local data directory you want to back up, and `${configPath}` with the path to your Rclone configuration file. Alternatively, define them directly in the env file (recommended).

3. Modify the `CRON_SCHEDULE` and `RCLONE_COMMAND` environment variables as needed, representing the scheduled task time and the Rclone command to run, respectively.

4. Start the containers by running the following command:

```bash
docker-compose up -d
```

5. View container logs:

```bash
docker-compose logs -f
```

## Environment Variables

- `CRON_SCHEDULE`: Time for scheduled tasks in cron expression format, default is empty (no scheduled task).
- `RCLONE_COMMAND`: Rclone command to run, default is `rclone version`.
- `RUN_NOW`: Whether to execute the Rclone command once immediately when the container starts. Set to `true` to enable, default is `false`.

## Volumes

- `/data`: Mounted local data directory for backup.
- `/config/rclone.conf`: Mounted path to the Rclone configuration file.

## Logging

The container uses the `json-file` logging driver, storing log files in the `/var/log/rclone` directory inside the container. Each log file is limited to 10MB, with a maximum of 3 log files retained.

## Examples

Here are some usage examples:

1. Backup the `/home/user/data` directory to a remote storage named `remote` every day at 3 AM:

```yaml
version: '3'

services:
  rclone-backup:
    image: austinwenyz/rclone-backup:latest
    container_name: rclone-backup
    restart: always
    volumes:
      - /home/user/data:/data
      - /home/user/.config/rclone/rclone.conf:/config/rclone.conf
    environment:
      - CRON_SCHEDULE=0 3 * * *
      - RCLONE_COMMAND=rclone copy /data remote:/backup --progress
```

2. Synchronize the `/home/user/data` directory to a remote storage named `remote` immediately upon container startup:

```yaml
version: '3'

services:
  rclone-backup:
    image: austinwenyz/rclone-backup:latest
    container_name: rclone-backup
    restart: always
    volumes:
      - /home/user/data:/data
      - /home/user/.config/rclone/rclone.conf:/config/rclone.conf
    environment:
      - RCLONE_COMMAND=rclone sync /data remote:/backup --progress
      - RUN_NOW=true
```

## License

This project is released under the MIT License.

# Rclone Backup Docker 中文说明

这是一个基于Alpine Linux的轻量级Docker镜像，用于使用Rclone进行文件备份和同步。它支持定时任务和即时运行，可以方便地将本地文件备份到各种云存储服务。

## 特点

- 基于Alpine Linux，镜像体积小，资源占用低。
- 预装Rclone，支持多种云存储服务。
- 支持定时任务，可以按照指定的时间自动运行备份。
- 支持即时运行，可以在容器启动时立即执行一次备份。
- 可以通过环境变量自定义Rclone命令和定时任务时间。
- 支持日志记录，方便查看备份状态和排查问题。

## 使用方法

1. 创建一个名为`docker-compose.yml`的文件，内容如下：

```yaml
version: '3'

services:
  rclone-backup:
    image: austinwenyz/rclone-backup:latest
    container_name: rclone-backup
    restart: always
    volumes:
      - ${dataPath}:/data
      - ${configPath}:/config/rclone.conf
    environment:
      - CRON_SCHEDULE=0 3 * * *
      - RCLONE_COMMAND=ls /data/config --progress
      - RUN_NOW=true
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
        
  rclone-backupMore:
    image: austinwenyz/rclone-backup:latest
    container_name: rclone-backupMore
    restart: always
    volumes:
      - ${dataPath}:/data
      - ${configPath}:/config/rclone.conf
    environment:
      - CRON_SCHEDULE=0 3 * * *
      - RCLONE_COMMAND=ls 123Pan:/SYNC/ --progress
      - RUN_NOW=true
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

2. 替换`${dataPath}`为你要备份的本地数据目录，`${configPath}`为你的Rclone配置文件路径。或者直接在env文件中定义（推荐）

3. 根据需要修改`CRON_SCHEDULE`和`RCLONE_COMMAND`环境变量，分别表示定时任务时间和要运行的Rclone命令。

4. 运行以下命令启动容器：

```bash
docker-compose up -d
```

5. 查看容器日志：

```bash
docker-compose logs -f
```

## 环境变量

- `CRON_SCHEDULE`: 定时任务的时间，格式为cron表达式，默认为空（不运行定时任务）。
- `RCLONE_COMMAND`: 要运行的Rclone命令，默认为`rclone version`。
- `RUN_NOW`: 是否在容器启动时立即执行一次Rclone命令，设置为`true`启用，默认为`false`。

## 数据卷

- `/data`: 挂载的本地数据目录，用于备份。
- `/config/rclone.conf`: 挂载的Rclone配置文件路径。

## 日志

容器使用`json-file`日志驱动，日志文件存储在容器内的`/var/log/rclone`目录下。单个日志文件最大为10MB，最多保留3个日志文件。

## 示例

以下是一些使用示例：

1. 每天凌晨3点将本地的`/home/user/data`目录备份到名为`remote`的远程存储：

```yaml
version: '3'

services:
  rclone-backup:
    image: austinwenyz/rclone-backup:latest
    container_name: rclone-backup
    restart: always
    volumes:
      - /home/user/data:/data
      - /home/user/.config/rclone/rclone.conf:/config/rclone.conf
    environment:
      - CRON_SCHEDULE=0 3 * * *
      - RCLONE_COMMAND=rclone copy /data remote:/backup --progress
```

2. 在容器启动时立即将本地的`/home/user/data`目录同步到名为`remote`的远程存储：

```yaml
version: '3'

services:
  rclone-backup:
    image: austinwenyz/rclone-backup:latest
    container_name: rclone-backup
    restart: always
    volumes:
      - /home/user/data:/data
      - /home/user/.config/rclone/rclone.conf:/config/rclone.conf
    environment:
      - RCLONE_COMMAND=rclone sync /data remote:/backup --progress
      - RUN_NOW=true
```

## 许可证

本项目基于MIT许可证发布。
