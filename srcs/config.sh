#	config NGINX
mkdir var/www/localhost
rm /etc/nginx/sites-enabled/default
mv ./temp/default /etc/nginx/sites-available/

ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

#	create SSL certificate
openssl genrsa -out /etc/ssl/private/nginx.key 4096
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42Madrid/CN=127.0.0.1" -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

#	load PHPMYADMIN
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
tar -xzvf phpMyAdmin-5.0.1-english.tar.gz
mv phpMyAdmin-5.0.1-english var/www/localhost/phpmyadmin
mv ./temp/config.inc.php var/www/localhost/phpmyadmin
rm phpMyAdmin-5.0.1-english.tar.gz
chmod 660 /var/www/localhost/phpmyadmin/config.inc.php
chown -R www-data:www-data /var/www/localhost/phpmyadmin

#	load WordPress
wget https://wordpress.org/latest.tar.gz
tar xvf latest.tar.gz
rm latest.tar.gz
mv wordpress /var/www/localhost/
chown -R www-data.www-data -R /var/www/localhost/wordpress/*
mv ./temp/wp-config.php /var/www/localhost/wordpress

#	start the services
service mysql start
service php7.3-fpm start
service nginx start

#	config database
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'chuchi'@'localhost' IDENTIFIED BY '123';" | mysql -u root
echo "GRANT ALL ON *.* TO 'chuchi'@'localhost' IDENTIFIED BY '123'" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
mysql wordpress -u root --password=  < /temp/wordpress.sql

echo "Wellcome to FT_SERVER"
echo "by jeserran"
echo "42 Madrid"

#	left the console open
bash