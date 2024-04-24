
#!/bin/bash


#Variables
USERID=$(id -u)
repo="reto-01"
bdd="devopstravel"


if [ "${USERID}" -ne 1000 ];
   then echo -e "correr como usuario root"
   exit
fi

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
 sudo systemctl status mariadb


if dpkg -l | grep apache2;
   then echo "ya esta instalado apache 2"
   else
     echo "instalando apache 2"
     sudo apt install apache2 -y
     sudo apt install php libapache2-mod-php php-mysql php-mbstring php-zip php-gd php-json php-curl -y
fi

sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl status apache2

php -v



sudo sed -i's/DirectoryIndex index.php/DirectoryIndex index.html/DirectoryIndex index.cgi/DirectoryIndex index.pl/DirectoryIndex index.xhtml/DirectoryIndex index.htm/' /etc/apache2/mods-enabled/dir.conf


sudo systemctl reload apache2

#sudo curl localhost/info.php

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
    sudo mysql < desafio01/app-295devops-travel/database/devopstravel.sql
fi


# Aplicacion WEB
if [ -d "desafio01" ];
   then
     echo "Ya existe la carpeta del Repo, Actualizando Repo"
     sleep 10
     cd desafio01
     git pull origin clase2-linux-bash
   else
    echo "Instalando Repo Aplicacion"
    sleep 10
    git clone -b clase2-linux-bash https://github.com/roxsross/bootcamp-devops-2023.git desafio01
    cd desafio01
fi

git checkout clase2-linux-bash
cd --
cd desafio01/app-295devops-travel
sudo sed -i 's/""/"codepass";/g' config.php
if  [ $? -eq 0 ];
     then 
      echo "configuraciopn Conexion ejecutada"
     else
       ls
       pwd
fi

cd --
sudo cp -r desafio01/app-295devops-travel/*  /var/www/html/
sleep 2

#configurar acceso a BdD de la app
#sudo

#copiar directorio de la app
#sudo mv /var/www/html/index.html  /var/www/html/index.html.bkp

sudo systemctl reload apache2

# Notificacion a DISCORD

discord_str="https://discord.com/api/webhooks/1169002249939329156/7MOorDwzym-yBUs3gp0k5q7HyA42M5eYjfjpZgEwmAx1vVVcLgnlSh4TmtqZqCtbupov"
cd --
cd desafio01
fullpayload=(
      "Challenge 01 Web Application deploy using Bash Scripting"
      "CodeBase Information:Sitio WEB En linea"
      "Github Repo: https://github.com/roxsross/bootcamp-devops-2023"
      "Author: Author $(git log -1 --pretty=format:'%an')"
      "Commit ID: $(git rev-parse --short HEAD)"
      "Commit Message: $(git log -1 --pretty=format:'%an')"
      "WebApp Status: Online"
      "Automation Script Information:"
      "Maintainer: Elba Mujica"
      "Github Repo: https://github.com/Elbam/295DEVOPS" 
      "Script details: Please refer to the README.md"

    )

    for payload in "${fullpayload[@]}"; do
      curl -X POST -H "Content-Type: application/json" -d '{
        "content": "'"$payload"'"
      }' "$discord_str"
    done
