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
sshpass -p "$PASSWORD" scp -r app/module1/nosie/* "$USER@$IP:/tmp/module1"
sshpass -p "$PASSWORD" scp -r app/module1/nosie/* "$USER@$IP:/tmp/module1"
sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USER@$IP" 'echo "$PASSWORD" | sudo -S bash /tmp/module1/main.sh'
sshpass -p "$PASSWORD" scp "$USER@$IP:/tmp/module1/report.html" app/templates/report.html
sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USER@$IP" 'rm -rf /tmp/module1'

echo '{% extends "appbuilder/base.html" %}
{% block content %}' | cat - app/templates/report.html > temp && mv temp app/templates/report.html


echo "{% endblock %}" >> app/templates/report.html


#sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USER@$IP" 'bash /tmp/r0.sh'

