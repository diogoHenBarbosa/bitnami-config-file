#!/usr/bin/env bash

function attEinstallDep(){
  sudo apt-get update -y 
  sudo apt-get upgrade -y
  sudo apt-get install net-tools nmap mc -y
  clear
}

function confArquivos(){
  echo "Conf. os arquivos"
  sudo cp ./conf/pg_hba.conf /opt/bitnami/postgresql/conf/pg_hba.conf
  sudo cp ./conf/postgresql.conf /opt/bitnami/postgresql/conf/postgresql.conf
  sleep 5
  clear
}

function habilitandoFirewall(){
  echo "Habilitando Firewall"
  sudo ufw allow 5432
  sudo ufw allow 3000
  sleep 5
}

function restServidor(){
  echo "Rest. Servidor"
  sudo service bitnami restart postgresql
  sleep 10
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

function downloadPostREST(){
  wget https://github.com/PostgREST/postgrest/releases/download/v10.0.0/postgrest-v10.0.0-linux-static-x64.tar.xz

  tar -xvf postgrest-v10.0.0-linux-static-x64.tar.xz
}

function configFilePOSTGREST(){
  touch tutorial.conf
  echo db-uri = "postgres://authenticator:passwd@127.0.0.1:5432/postgres" >> tutorial.conf
  echo db-schemas = "public" >> tutorial.conf
  echo db-anon-role = "web_anon" >> tutorial.conf
}

function permisionTutorial(){
  chmod +x postgrest
}

function main(){
  attEinstallDep
  confArquivos
  habilitandoFirewall
  restServidor
  credentials
  downloadPostREST
  configFilePOSTGREST
  permisionTutorial
  exit
}

main