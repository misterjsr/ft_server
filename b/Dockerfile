# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jeserran <jeserran@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/05 15:57:51 by jeserran          #+#    #+#              #
#    Updated: 2020/03/10 11:09:33 by jeserran         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

LABEL maintainer: jeserran <jeserran@student.42.fr>

#	instalamos y actualizamos los paquetes del sistema
RUN	apt-get -y update && apt-get -y upgrade

#	instalamos aplicaciones
RUN	apt-get install -y nginx \
	mariadb-server mariadb-client \
	php-fpm php-mysql

#	instalamos herramienta
RUN	apt-get install -y wget

#configure nginx to load automacly wordpress page
COPY src/default /etc/nginx/sites-available/


#	creamos SSL key y la certificamos
RUN		mkdir ~/mkcert && \
		cd ~/mkcert && \
		wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64 && \
		mv mkcert-v1.1.2-linux-amd64 mkcert && \
		chmod +x mkcert && \
		./mkcert -install && \
		./mkcert localhost
#RUN 	rm var/www/html/index.nginx-debian.html

#	descargamos WordPress y damos derechos
RUN cd var/www/html && wget http://wordpress.org/latest.tar.gz  && \
tar -xzvf latest.tar.gz && rm latest.tar.gz 
RUN cd var/www/html && cp -a wordpress/* . && rm -r wordpress
RUN chown -R www-data:www-data /var/www/html/ && chmod -R 755 /var/www/html/  
COPY src/wp-config.php /var/www/html/
		
#		descargamos phpMyAdmin
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
		tar -xzvf phpMyAdmin-5.0.1-english.tar.gz && \
		mv phpMyAdmin-5.0.1-english /var/www/html/phpmyadmin && \
		rm phpMyAdmin-5.0.1-english.tar.gz
COPY 	src/config.inc.php ./var/www/html/phpmyadmin

#		copiamos los archivos
COPY	./src/info.php ./var/www/html
#COPY	./src/wp-config.php ./var/www/html/wordpress/wp-config.php
COPY	./src/wordpress.sql ./wordpress.sql
COPY  	./src/db_wordpress.sql	./db_wordpress.sql

#DATABASE SETUP
RUN service mysql start && \
	mysql -u root --password= < /db_wordpress.sql && \
	mysql wordpress -u root --password=  < ./wordpress.sql


#restart services
RUN service nginx restart

EXPOSE 80 443

CMD service nginx start && \
  service mysql start && \
  service php7.3-fpm start && \
  sleep infinity