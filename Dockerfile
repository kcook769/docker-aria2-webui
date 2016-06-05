FROM debian:latest
MAINTAINER kevin.t.cook@gmail.com

ENV aria2_host=192.168.1.52
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR &&\
apt-get update && apt-get install -y apache2 git openssl ca-certificates --no-install-recommends &&\
git clone 'https://github.com/ziahamza/webui-aria2.git' /tmp/webui-aria2 &&\
apt-get purge -y git openssl ca-certificates && apt-get remove -y --force-yes --purge --auto-remove systemd systemd-sysv && apt-get clean && rm -rf /var/lib/apt/lists/* &&\
rm -rf /var/www/html /tmp/webui-aria2/.git /tmp/webui-aria2/.gitignore && ln -s /tmp/webui-aria2/ /var/www/html &&\
sed -i "s/localhost/$aria2_host/g" /var/www/html/configuration.js

COPY daemon.sh /root/daemon.sh
RUN /bin/bash -c 'chmod u+x /root/daemon.sh'

ENTRYPOINT ["/root/daemon.sh"]
