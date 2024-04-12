#!/bin/bash

sudo apt-get update

#Fase de Instalacion

if dpkg -l | grep git;
   then echo "ya esta instalado git"
   else
   echo "instalando git"
   apt install git -y
fi

if dpkg -l | grep tree;
   then echo "ya esta instalado tree"
   else
   echo "instalando tree"
   apt install tree
fi


#Ejercicio Nro 1
uname -a > info_Sistema.txt

#Ejercicio >Nro 2
mkdir -p Desafio1/Ejercicio1 Desafio1/Ejercicio2 Desafio1/Ejercicio2/Prueba2
tree Desafio1 > arbol.txt 

#Ejercicio Nro 3
cat /etc/passwd > usuarios.txt

#Ejercicio Nro 4
pwd  -P >directorio_actual.txt

#Ejercicio Nro 5
touch arch1.txt arch2.txt arch3.txt arch4.txt arch5.txt
mkdir -p Archivos_creados
mv arch1.txt arch2.txt arch3.txt arch4.txt arch5.txt /Desatando-Automatizacion/Archivos_creados


#Ejercicio Nro 6
echo 'Introduzca NOmbre del Archivo a buscar'
read nombreA
find .  -name $nombreA -exec cat $nombreA {} \;

#Ejercicio Nro 7
tree -a

#Ejercicio Nro 8
echo "primera linea" > datos.txt
echo "segunda linea" >> datos.txt
echo "tercera linea" >> datos.txt
echo "cuarta oracion" >>  datos.txt
echo "quinta oracion" >> datos.txt
echo "sexta oracion" >> datos.txt
echo 'Introduzca palabra a buscar:'
read palabraB
grep $palabraB datos.txt >busqueda.txt

#Ejercicio Nro 9
#dt=`date +%y-%m`  ´
dt=$(date +"%y%m%d")
find . -type f -name "*.txt" -exec mv {} {}_$dt \;

#Ejercicio nro 10
ls -lh > lista_archivos.txt


#Ejercicio Nro 11
mkdir -p mi_proyecto mi_proyecto/documentos mi_proyecto/codigo mi_proyecto/codigo/utilidades 
cd mi_proyecto/documentos
echo "proyecto de Elba Mujica" > plan.txt
echo "el plan es aprender automatizacion " >>plan.txt
echo "la meta superior es ser DEVPOS" >> plan.txt
cd .. 
cd codigo
echo "hola mundo! " > main.sh
cd utilidades
echo "#!/bin/bash" >funciones.sh
echo "  " >> funciones.sh
echo "Introduzca Nombre Usuario:" >> funciones.sh
echo "read nombreU " >> funciones.sh
echo "Introduzca Apellido Usuario:" >> funciones.sh
echo "read apellidoU" >> funciones.sh

