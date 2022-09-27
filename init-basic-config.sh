#!/usr/bin/env bash

caminho_conf_post= "/opt/bitnami/postgresql/conf"

cd $caminho_conf_post

sudo su
ufw allow 5432
apt-get install net-tools nmap mc 
pwd 

echo "host  all        all        all        md5" >> $caminho_conf_post/pg_hba.conf

echo "listen_addresses = '*'" >> $caminho_conf_post/postgresql.conf