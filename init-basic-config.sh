#!/usr/bin/env bash
function exportPort(){
    export PORT_POSTGRESQL="5432"
    export PORT_POSTREST="3000"
    export USER= "postgres"
}

function defineSenhaPostgres(){
    export PASSWORD_POSTGRESQL= "$(grep "asd" /home/diogo-notebook-ubuntu/bitnami_credentials | cut -b 54-65)"
    echo $PASSWORD_POSTGRESQL
    echo $PORT_POSTGRESQL
    echo $PORT_POSTREST
    echo $USER
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
    sleep 5
    clear
}

function habilitandoFirewallPostgresql(){
    echo "Habilitando Firewall do Postgresql"
    sudo ufw allow $PORT_POSTGRESQL
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
    echo "--------------------------------------------------------------"
    echo "Digte a senha do seu arquivo postgresql:   "
    sleep 60
}

function habilitandoFirewallPostREST(){
    echo "Habilitando Firewall do PostREST"
    sudo ufw allow $PORT_POSTREST
    sleep 5
    
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
    ./postgrest tutorial.conf&
}

function confPostREST(){
    echo "Deseja Configurar o PostREST"
    select i in "Sim" "Não"
    do
        case $i in 
            "sim "
                variaveisDeAmbientePOSTREST
                defineSenhaPostgres
                downloadPostREST
                habilitandoFirewallPostREST
                restServidor
                configuracaoArquivoTutorialPostrest
                excREST
            ;;
            "nao")
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