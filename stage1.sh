
#!/bin/bash


#Variables
USERID=$(id -u)
bdd="devopstravel"


#sudo apt-get update

if dpkg -l | grep git;
   then echo "ya esta instalado git"
   else
   echo "instalando git"
   sudo apt install git -y
fi

if dpkg -l | grep curl;
   then echo "ya esta instalado curl"
   else
   echo "instalando curl"
   sudo apt install curl -y
fi


if dpkg -l | grep mariadb-server;
   then echo "ya esta instalado mariadb server"
   else
    echo "instalando mariadb server"
    sudo apt install mariadb-server -y
fi

 sudo systemctl start mariadb
 sudo systemctl enable mariadb
#sudo systemctl status mariadb


if dpkg -l | grep apache2;
   then echo "ya esta instalado apache 2"
   else
     echo "instalando apache 2"
     sudo apt install apache2 -y
     sudo apt install php libapache2-mod-php php-mysql php-mbstring php-zip php-gd php-json php-curl -y
fi

sudo systemctl start apache2
sudo systemctl enable apache2
#sudo systemctl status apache2

php -v



sudo sed -i's/DirectoryIndex index.php/DirectoryIndex index.html/DirectoryIndex index.cgi/DirectoryIndex index.pl/DirectoryIndex index.xhtml/DirectoryIndex index.htm/' /etc/apache2/mods-enabled/dir.conf


sudo systemctl reload apache2

#sudo curl localhost/info.php

# Aplicacion WEB
if [ -d "proyectof" ];
   then
     echo "Ya existe la carpeta del Repo, Actualizando Repo"
     sleep 10
     cd proyectof
     git pull origin clase2-linux-bash
   else
    echo "Instalando Repo Aplicacion"
    sleep 10
    git clone -b clase2-linux-bash https://github.com/roxsross/bootcamp-devops-2023.git proyectof
    cd proyectof
fi

#Base de Datos

sudo mysql -e "SHOW DATABASES LIKE '$bdd';" | grep devopstravel > /dev/null;

if [ $? -eq 0 ];
   then
      echo "Base de datos ya existe"
   else
    echo "Se creara la Base de Datos"
    sudo mysql -e "
    CREATE DATABASE devopstravel;
    CREATE USER 'codeuser'@'localhost' IDENTIFIED BY 'codepass';
    GRANT ALL PRIVILEGES ON *.* TO 'codeuser'@'localhost';
    FLUSH PRIVILEGES;"
    sudo mysql < app-295devops-travel/database/devopstravel.sql
fi


git checkout clase2-linux-bash
#cd --
cd app-295devops-travel
sudo sed -i 's/""/"codepass";/g' config.php
if  [ $? -eq 0 ];
     then 
      echo "configuraciopn Conexion ejecutada"
     else
       ls
       pwd
fi

cd --
sudo cp -r *  /var/www/html/
sleep 2

#configurar acceso a BdD de la app
#sudo

#copiar directorio de la app
#sudo mv /var/www/html/index.html  /var/www/html/index.html.bkp

sudo systemctl reload apache2
