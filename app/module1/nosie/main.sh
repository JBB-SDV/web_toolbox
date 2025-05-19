#!/bin/bash

# Mettre à jour les paquets et installer les outils nécessaires
echo "[+] Mise à jour des paquets et installation des outils nécessaires..."
apt-get update && apt-get install -y \
    wget ssg-base ssg-debderived ssg-debian ssg-nondebian ssg-applications

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
    if [ "$VERSION" = "12" ]; then
        oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_anssi_np_nt28_high --report /tmp/module1/report.html /tmp/module1/ssg-debian12-ds.xml

    elif [ "$VERSION" = "11" ]; then
        oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_anssi_np_nt28_high --report /tmp/module1/report.html /tmp/module1/ssg-debian11-ds.xml
    fi
elif [ "$NAME" = "Ubuntu" ]; then
    oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_standard --report /tmp/module1/report.html /usr/share/xml/scap/ssg/content/ssg-ubuntu2204-ds.xml 
elif [ "$NAME" = "CentOS" ]; then
    oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_anssi_nt28_high --report /tmp/module1/report.html /tmp/module1/ssg-centos7-ds.xml

elif [ "$NAME" = "Red Hat" ]; then
    oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_standard --report /tmp/module1/report.html /tmp/module1/ssg-rhel6-ds.xml
else
    echo "Système non supporté."
    #Supprimer les outils installés après utilisation
    exit 1
fi
apt-get remove --purge -y wget ssg-base ssg-debderived ssg-debian ssg-nondebian ssg-applications && apt-get autoremove -y && apt-get clean
echo "[+] Suppression des outils installés..."
