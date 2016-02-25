FROM ubuntu:latest
MAINTAINER boogy <theboogymaster@gmail.com>

RUN apt-get update && \
    apt-get -y install apache2 php5 libapache2-mod-php5 && \
    apt-get clean

ENV APACHE_RUN_USER apache
ENV APACHE_RUN_GROUP apache
ENV APACHE_LOG_DIR /var/log/apache2

RUN ln -sf /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/001-default-ssl && \
    ln -sf /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/php5.conf /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/php5.load /etc/apache2/mods-enabled/

EXPOSE 80 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

