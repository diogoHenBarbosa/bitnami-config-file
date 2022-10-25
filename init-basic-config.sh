#!/usr/bin/env bash

PORT_POSTGRESQL="5432"
PORT_POSTREST="3000"
USER_POSTGRES= "postgres"
PASSWORD_POSTGRESQL= "$(grep "postgres" $HOME/bitnami_credentials | cut -b 54-65)"


function defineSenhaPostgres(){
    echo $PASSWORD_POSTGRESQL
    echo $PORT_POSTGRESQL
    echo $PORT_POSTREST
    echo $USER_POSTGRES
}

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
    echo "Vai ficar nesta tela por 60 segundos!"
    cat /home/bitnami/bitnami_credentials
    echo "--------------------------------------------------------------"
    echo "------------------------- Seu IP -----------------------------"
    sudo ifconfig
    echo "--------------------------------------------------------------"
    echo "Digte a senha do seu arquivo postgresql:   "
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
}

function configuracaoArquivoTutorialPostrest(){
    cp ./conf/postgrest/tutorial.conf .
}

function variaveisDeAmbientePOSTREST(){
    export command1="create role web_anon nologin;"
    export command2="grant usage on schema public to web_anon;"
    export command3="grant select on public.aisles to web_anon;"
    export command4="create role authenticator noinherit login password 'passwd';"
    export command5="grant web_anon to authenticator;"
    
}
function excREST(){
    ./postgrest tutorial.conf
}

function confPostREST(){
    echo "Deseja Configurar o PostREST - 1 ou 2 "
    select i in Sim Não
    do
        case $i in
            "Sim")
                variaveisDeAmbientePOSTREST
                defineSenhaPostgres
                sleep 30
                downloadPostREST
                habilitandoFirewallPostREST
                restServidor
                configuracaoArquivoTutorialPostrest
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
    exportPort
    attEinstallDep
    confArquivos
    habilitandoFirewallPostgresql
    restServidor
    confPostREST
    credentials
    exit
}

main