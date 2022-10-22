#!/usr/bin/env bash
function defineSenhaPostgres(){
    export PASSWORD_POSTGRESQL= 'grep "\'************\'" ./bitnami_credentials | cut -b 54-65"
}