FROM debian:latest
MAINTAINER kevin.t.cook@gmail.com

ENV aria2_host=192.168.1.52
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR
RUN apt-get update && apt-get install -y apache2 git openssl ca-certificates --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

RUN /bin/bash -c 'git clone https://github.com/ziahamza/webui-aria2.git /tmp/webui-aria2'
RUN /bin/bash -c 'rm -rf /var/www/html /tmp/webui-aria2/.git /tmp/webui-aria2/.gitignore'
RUN /bin/bash -c 'ln -s /tmp/webui-aria2/ /var/www/html'
RUN /bin/bash -c 'sed -i "s/localhost/$aria2_host/g" /var/www/html/configuration.js'

ENTRYPOINT ["/usr/sbin/apache2", "-D", "FOREGROUND"]
