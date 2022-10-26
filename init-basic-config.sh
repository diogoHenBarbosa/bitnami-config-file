#!/usr/bin/env bash

COMMNAD_POSTGREST=("create role web_anon nologin;" "grant usage on schema public to web_anon;" "grant select on public.aisles to web_anon;" "create role authenticator noinherit login password 'passwd';" "grant web_anon to authenticator;")
PORT_POSTGRESQL="5432"
PORT_POSTREST="3000"
USER_POSTGRES="postgres"
PASSWORD_POSTGRESQL=$(grep "postgres" $HOME/bitnami_credentials | cut -b 54-65)

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
    clear
}

function ajusteParaOPostREST(){
    for ((i=0; i<= ${#COMMNAD_POSTGREST[@]}; i++))
    do
        PGPASSWORD=$PASSWORD_POSTGRESQL psql -h localhost -p 5432 -U postgres --command=${COMMNAD_POSTGREST[i]}
        sleep 3
    done
    
}

function habilitandoFirewallPostgresql(){
    echo "Habilitando Firewall do Postgresql"
    sudo ufw allow $PORT_POSTGRESQL
}

function restServidor(){
    echo "Rest. Servidor"
    sudo service bitnami restart postgresql
    clear
}

function credentials(){
    cat /home/bitnami/bitnami_credentials
    echo "--------------------------------------------------------------"
    echo "------------------------- Seu IP -----------------------------"
    sudo ifconfig
    echo "--------------------------------------------------------------"
    echo "Aperte Ctrl+C para sair"
    sleep 60
}

function habilitandoFirewallPostREST(){
    clear
    echo "Habilitando Firewall do PostREST"
    sudo ufw allow $PORT_POSTREST
}

function downloadPostREST(){
    wget https://github.com/PostgREST/postgrest/releases/download/v10.0.0/postgrest-v10.0.0-linux-static-x64.tar.xz
    tar -xvf postgrest-v10.0.0-linux-static-x64.tar.xz
    rm postgrest-v10.0.0-linux-static-x64.tar.xz
}

function excREST(){
    ./postgrest ./conf/postgrest/tutorial.conf
}

function infRest(){
    clear
    echo "Espere a Conf. do PostREST!"
    sleep 5
}


function confPostREST(){
    echo "Deseja Configurar o PostREST - 1 ou 2 "
    select i in Sim Não
    do
        case $i in
            "Sim")
                downloadPostREST
                habilitandoFirewallPostREST
                infRest
                restServidor
                ajusteParaOPostREST
                credentials
                excREST
            ;;
            "Não")
                break
            ;;
            
            *)
                continue
            ;;
        esac
    done
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