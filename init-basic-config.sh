#!/usr/bin/env bash
sudo apt-get update -y 
sudo apt-get upgrade -y
sudo apt-get install net-tools nmap mc -y
clear
echo "host  all        all        all        md5" >> /opt/bitnami/postgresql/conf/pg_hba.conf
echo "listen_addresses = '*'" >> /opt/bitnami/postgresql/conf/postgresql.conf
echo "Conf. os arquivos"
sleep 5
clear
sudo ufw allow 5432
service bitnami restart postgresql
clear

echo "Vai ficar nesta tela por 60 segundos!"
cat $HOME/bitnami_credentials
sleep 60
exit
