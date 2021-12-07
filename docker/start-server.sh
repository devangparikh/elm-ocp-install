#!/bin/bash

if [ ! -d "/IBM/JazzTeamServer/server/liberty/servers" ] 
then
    echo "Error Directory /IBM/JazzTeamServer/server/liberty/servers does not exists."
    exit 1
fi


if [ -d "/IBM/JazzTeamServer/server/conf" ] 
then
    if [ -z "$(ls -A /IBM/JazzTeamServer/server/conf)" ] 
    then
        cp -R /IBM/JazzTeamServer/server/confTemplate/* /IBM/JazzTeamServer/server/conf
    fi
    /IBM/JazzTeamServer/server/server.startup
    tail -f /dev/null
else
    echo "Error: Directory /IBM/JazzTeamServer/server/conf does not exists."
fi