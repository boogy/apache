Ubuntu apache server
=====================

Docker image based on ubuntu which provides apache server with php and ssl.

Pull from docker hub
```bash
docker pull boogy/apache-php
```

Build the image localy

```bash
git clone https://github.com/boogy/apache-php.git
cd apache-php
docker build -t username/apache-php .
```

Run the a simple server:

```bash
docker run -d -p 80:80 -p 443:443 boogy/apache-php
```

Run a server with your website

```bash
docker run -d -p 80:80 -p 443:443 -u $UID -v /home/user/mysite:/var/www/html boogy/apache-php
```

