# docker-symfony
Docker Image for Symfony Project

I've created a image contain nginx and php7.1-fpm services for a new symfony project but this image usable any php project with any php framework. It's generic. 
Php modules are bellow:
  * php7.1-pgsql
  * php7.1-mysql
  * php7.1-intl
  * php7.1-gd
  * php7.1-memcached
  * php7.1-imagick
  * php7.1-xdebug
  * php7.1-curl
  * php7.1-apcu
  * php7.1-imap
  * php7.1-mongo
  * php7.1-xml
  * php7.1-zip
  * php7.1-sqlite3
  
conf/project-site.conf file is your project website config file. 
You can mount your project for costimizing. 

this config file configured "/var/vhosts/myproject/web" directory as project web root. 
You can customize and mount you local directory to this host directory.

sample docker-compose.yml file is bellow:

```yml
version: '2'
services:
  my_project:
    ports:
      - "80:80"
      - "9000:9000"
    image: "aerkanc/phpproject:latest"
    volumes:
      - "~/Workspaces/PHP/myproject:/var/vhosts/myproject"
      - "dockerize/project-site.conf:/etc/nginx/sites-available/project-site.conf"
    networks:
      myproject_net:
        ipv4_address: 172.18.0.10
networks:
  myproject_net:
    driver: "bridge"
    ipam:
      driver: default
      config:
        - subnet: 172.18.0.0/16