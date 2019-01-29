#!/bin/bash

echo "$(docker rm -f mariadb)";
echo "$(docker rm -f nginx)";
echo "$(docker rm -f datacontainer)";

echo "$(docker create --name datacontainer --hostname datacontainer -v DataVolume2:/usr/share/nginx/html -v DataVolume2:/var/lib/mysql centos)";

echo "$(docker run --name mariadb --hostname mariadb -e USER=myusername -e PASSWORD=mypassword -e MYSQL_ROOT_PASSWORD=mariadb -e MYSQL_DATABASE1=moodle -e MYSQL_USER1=moodle -e MYSQL_PASSWORD1=moodle --volumes-from datacontainer -p 3306:3306 -d orboan/dcsss-mariadb)";

echo "$(docker run --name nginx --link mariadb:mariadb --hostname nginx -p 8082:80 -d --volumes-from datacontainer nginx)";

echo "$(wget http://wordpress.org/latest.tar.gz)";
echo "$(tar xzvf latest.tar.gz)";
echo "$(docker cp wordpress datacontainer:/var/lib/mysql/)";
echo "$(rm -f latest.tar.gz)";

echo "$(docker cp wp-config.php datacontainer:/usr/share/nginx/html/wordpress/)";

