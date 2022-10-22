#!/usr/bin/env bash
function defineSenhaPostgres(){
    PASSWORD_POSTGRESQL= grep \'*\' $HOME/bitnami_credentials | cut -b 54-65
    echo $PASSWORD_POSTGRESQL
}

defineSenhaPostgres