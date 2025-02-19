FROM alpine:latest

RUN apk add --no-cache --no-interactive \
    bash \
    cronie \
    logrotate \
    curl

#RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY backup.sh /usr/local/bin/backup.sh
COPY backup_my_page_logrotate_config /etc/logrotate.d/backup_my_page_logrotate_config
COPY config.env /config.env
COPY cronjob /etc/crontab

RUN chmod +x /usr/local/bin/backup.sh && \
    chmod 0644 /etc/crontab && \
    mkdir -p /backups 
    #&& chown appuser:appgroup /backups

#USER appuser

#CMD ["crond", "-f"]
ENTRYPOINT crond -f