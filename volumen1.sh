#!/bin/bash


echo"$(rm -f apache2)";
echo"$(rm -f nginx)";
echo"$(rm -f datacontainer)";


echo "$(docker create --name datacontainer --hostname datacontainer -v DataVolume:/var/www/html -v DataVolume:/usr/share/nginx/html centos)";

echo "$(docker cp prueba.html datacontainer:/var/www/html/)";
echo "$(docker cp prueba.html datacontainer:/usr/share/nginx/html/)";

echo "$(docker run --name apache2 --hostname apache2 -p 8081:80 -d --volumes-from datacontainer amrojas/centos-httpd-php-amrojas1)";

echo "$(docker run --name nginx --hostname nginx -p 8080:80 -d --volumes-from datacontainer nginx)";
