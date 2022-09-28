#!/usr/bin/env bash

function attEinstallDep(){
  sudo apt-get update -y 
  sudo apt-get upgrade -y
  sudo apt-get install net-tools nmap mc -y
  clear
}

function confArquivos(){
  echo "Conf. os arquivos"
  sudo cp ./conf/postgresql.conf /opt/bitnami/postgresql/conf/pg_hba.conf
  sudo cp ./conf/postgresql.conf /opt/bitnami/postgresql/conf/postgresql.conf
  sleep 5
  clear
}

function habilitandoFirewall(){
  echo "Habilitando Firewall"
  sudo ufw allow 5432
  sleep 5
}

function restServidor(){
  echo "Rest. Servidor"
  service bitnami restart postgresql
  clear
}
function credentials(){
  echo "Vai ficar nesta tela por 60 segundos!"
  cat /home/bitnami/bitnami_credentials
  echo "--------------------------------------------------------------"
  echo "------------------------- Seu IP -----------------------------"
  sudo ifconfig
  sleep 60
}

function main(){
  attEinstallDep
  confArquivos
  habilitandoFirewall
  restServidor
  credentials
  exit
}

main