#!/bin/bash

sudo apt-get update

#Fase de Instalacion

if dpkg -l | grep git;
   then echo "ya esta instalado git"
   else
   echo "instalando git"
   sudo apt install git -y
fi

if dpkg -l | grep tree;
   then echo "ya esta instalado tree"
   else
   echo "instalando tree"
   sudo apt install tree
fi


#Ejercicio Nro 1
uname -a > info_Sistema.txt

#Ejercicio >Nro 2
mkdir -p Desafio1/Ejercicio1 Desafio1/Ejercicio2 Desafio1/Ejercicio2/Prueba2
tree Desafio1 > arbol.txt 

