# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jeserran <jeserran@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/24 20:14:14 by jeserran          #+#    #+#              #
#    Updated: 2020/09/11 19:26:57 by jeserran         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

LABEL MAINTAINER jeserran <jeserran@student.42.fr>

#	install and update system packages
RUN apt-get update
RUN apt-get install -y wget

#	install nginx
RUN apt-get install -y nginx


#	install SSL
RUN apt-get install openssl

#	intallMysql
RUN apt-get install -y mariadb-server mariadb-client

#	install PHP
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline
RUN apt-get install -y php-mbstring php-zip php-gd
RUN apt-get install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

#	copy configuration files and the index
RUN mkdir /temp
COPY srcs/config.inc.php ./temp
COPY srcs/config.sh ./temp
COPY srcs/index.html ./var/www/localhost/
COPY srcs/info.php ./var/www/localhost/
COPY srcs/default ./temp
COPY srcs/wordpress.sql ./temp
COPY srcs/wp-config.php ./temp
COPY srcs/autoindex.sh ./
RUN mkdir /turnoff

#	open the ports
EXPOSE 80
EXPOSE 443

#	start the configuration
CMD bash /temp/config.sh
