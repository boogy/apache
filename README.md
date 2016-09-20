Ubuntu apache server
=====================
[![](https://images.microbadger.com/badges/image/boogy/apache-php.svg)](https://microbadger.com/images/boogy/apache-php "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/boogy/apache-php.svg)](https://microbadger.com/images/boogy/apache-php "Get your own version badge on microbadger.com")

Docker image based on debian which provides apache server with php and ssl.

Pull from docker hub
```bash
docker pull boogy/apache-php
```

Build the image localy

```bash
git clone https://github.com/boogy/apache-php.git
cd apache-php
docker build -t boogy/apache-php .
```

Run the a simple server:

```bash
docker run -d -p 80:80 -p 443:443 boogy/apache-php
```

Run a server with your website

```bash
docker run -d -p 80:80 -p 443:443 -u $UID -v /home/user/mysite:/var/www/html boogy/apache-php
```

## A note on SSL

As per the defaults, Apache will use the bundled "snakeoil" key when serving SSL. Obviously this isn't sufficient or advisable for production, so you'll want to mount your real keys onto /etc/ssl/. If you name them "certs/ssl-cert-snakeoil.pem" and "private/ssl-cert-snakeoil.key", you'll be able to get by with the default config. Otherwise, you'll want to include a revised site definition. If you don't want to use SSL, you can avoid forwarding port 443 when launching the container (see below).

## Example of apache instance with letsencrypt ssl certificate:

### Generate ssl certificate on ubuntu:

**The certificate was generated on a ubuntu machine.**
```bash
sudo apt-get install python-letsencrypt-apache
sudo letsencrypt --apache -d mydomaine.com -d www.mydomaine.com
```

If you want only the ssl certificate and modify the apache configuration on your own do:

```bash
sudo letsencrypt --apache certonly -d mydomaine.com -d www.mydomaine.com
```

### Run the container with letsencrypt ssl:

```bash
docker run -d -p 80:80 -p 443:443
    -v /home/user/mysite/:/var/www/html \
    -v /etc/letsencrypt/live/mydomaine.com/fullchain.pem:/etc/ssl/certs/ssl-cert-snakeoil.pem \
    -v /etc/letsencrypt/live/mydomaine.com/privkey.pem:/etc/ssl/private/ssl-cert-snakeoil.key \
    -v /home/user/logs:/var/log/apache2 \
    boogy/apache-php
```

#### NOTE
This configuration was inspired by [eboraas/apache](https://hub.docker.com/r/eboraas/apache/)
