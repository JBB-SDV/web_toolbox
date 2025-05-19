#!/bin/bash

# Détection de l'OS principal
OS_NAME="$(uname -s)"

# Vérification si le fichier /etc/os-release existe pour récupérer les infos
if [ -f /etc/os-release ]; then
    # On extrait les infos lisibles de /etc/os-release
    . /etc/os-release
else
    echo "Impossible de détecter l'OS."
    exit 1
fi

# Conditions selon le nom et la version de l'OS
if [ "$NAME" = "Debian" ]; then
    if [ "$VERSION" = "11" ]; then
        echo "Debian 11 détecté, action spécifique."
    elif [ "$VERSION" = "12" ]; then
        echo "Debian 12 détecté, action spécifique."
    else
        echo "Autre version de Debian."
    fi
elif [ "$NAME" = "Ubuntu" ]; then
    echo "Ubuntu détecté."
elif [ "$NAME" = "CentOS" ]; then
    echo "CentOS détecté."
elif [ "$NAME" = "Red Hat" ]; then
    echo "Red Hat détecté."
else
    echo "Système non supporté."
    exit 1
fi
