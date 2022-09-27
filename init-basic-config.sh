#!/usr/bin/env bash
ufw allow 5432
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install net-tools nmap mc -y

echo "host  all        all        all        md5" >> /opt/bitnami/postgresql/conf/pg_hba.conf

echo "listen_addresses = '*'" >> /opt/bitnami/postgresql/conf/postgresql.conf

service bitnami restart postgresql