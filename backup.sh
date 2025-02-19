#!/bin/bash

source /config.env

if [ -z "$BACKUP_URL" ]; then
  echo "Ошибка: Переменная BACKUP_URL не найдена в конфигурационном файле."
  exit 1
fi

BACKUP_DIR="/backups"

# Создаём бэкап
echo "Создаю бэкап..."
#todo: hideme
curl "$BACKUP_URL" > "$BACKUP_DIR/backup_$(date +%Y%m%d).html"

# Запускаем logrotate
echo "Запускаю logrotate..."
logrotate -v /etc/logrotate.d/backup_my_page_logrotate_config