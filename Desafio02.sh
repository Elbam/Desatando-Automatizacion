#!/bin/bash

creararchivo(){}
agregar(){}
editararchivo(){}
eliminararchivo(){}
buscar(){}
listar(){}
respaldar(){}
restaurar(){}

while :
do
  echo "Herrramienta Configuracion"
  echo "1.  Crear Archivo"
  echo "2.  Agregar Configuracion"
  echo "3.  Editar"
  echo "4.  Eliminar Archivo"
  echo "5.  Listar"
  echo "6.  Buscar"
  echo "7.  Hacer Copia"
  echo "8.  Restaurar"
  echo "9. Salir"
  read -p "elige opcion" opcion
  case $opcion in
      1) agregar ;;
      2) agregar ;;
      3) editar ;;
      4) eliminar ;; 
      5) listar ;;
      6) buscar ;;
      7) respaldar ;;
      8) restaurar ;;
      9) break ;;
      *) echo "Seleccion no valida";;
  esac
done
