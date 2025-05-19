#!/bin/bash


# Vérification du nombre d'arguments
if [ "$#" -ne 3 ]; then
    echo "Rajoute les arguments batard"
    exit 1
fi

USER=$1
IP=$2
PASSWORD=$3


sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USER@$IP" 'rm -rf /tmp/module1 && mkdir /tmp/module1'
sshpass -p "$PASSWORD" scp -r app/module1/sie/* "$USER@$IP:/tmp/module1"
sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USER@$IP" 'bash /tmp/module1/r0.sh'
sshpass -p "$PASSWORD" scp "$USER@$IP:/tmp/module1/mod1.json" app/json/mod1.json 
sshpass -p "$PASSWORD" scp -r "$USER@$IP:/tmp/module1/output" app/module1/sie
sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USER@$IP" 'rm -rf /tmp/module1'

#sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USER@$IP" 'bash /tmp/r0.sh'

