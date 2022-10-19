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

function habilitandoFirewallPostgresql(){
  echo "Habilitando Firewall do Postgresql"
  sudo ufw allow 5432
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
  sleep 5
}

function habilitandoFirewallPostREST(){
  echo "Habilitando Firewall do PostREST"
  sudo ufw allow 3000
  sleep 5

}

function downloadPostREST(){
  wget https://github.com/PostgREST/postgrest/releases/download/v10.0.0/postgrest-v10.0.0-linux-static-x64.tar.xz

  tar -xvf postgrest-v10.0.0-linux-static-x64.tar.xz
}

function configuracaoArquivoTutorialPostrest(){
  cp ./conf/postgrest/tutorial.conf .
  
}


function permisionTutorial(){
  ./postgrest tutorial.conf&
}

function confPostREST(){
  downloadPostREST
  habilitandoFirewallPostREST
  configuracaoArquivoTutorialPostrest
  permisionTutorial
  restServidor
}

function main(){
  attEinstallDep
  confArquivos
  habilitandoFirewallPostgresql
  restServidor
  confPostREST
  credentials
  exit
}

main