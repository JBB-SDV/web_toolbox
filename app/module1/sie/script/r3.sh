#!/bin/bash
# Liste des dépôts officiels d'Ubuntu
OFFICIAL_REPOS=(
    "archive.ubuntu.com"
    "security.ubuntu.com"
    "fr.archive.ubuntu.com"
    "ppa.launchpad.net"
    "ppa.launchpadcontent.net"
)

DEB_SOURCES=$(grep -hE '^[^#]' /etc/apt/sources.list /etc/apt/sources.list.d/*.list 2>/dev/null | awk '{print $2}' | sed -E 's#(http|https)://##g' | cut -d '/' -f1 | sort -u)
for REPO in $DEB_SOURCES; do
    if [[ " ${OFFICIAL_REPOS[@]} " =~ " $REPO " ]]; then
        echo "Dépôt officiel : $REPO"
    else
        echo "Dépôt NON officiel : $REPO"
    fi
done


# Ajout du depot de spotify pour tester 
# A verifier depot RHEL
#OFFICIAL_REPOS=(
#    "rhel-8-for-x86_64-baseos-rpms"
#    "rhel-8-for-x86_64-appstream-rpms"
#    "rhel-8-for-x86_64-ansible-2.9-rpms"
#    "rhel-8-for-x86_64-optional-rpms"
#    "rhel-8-for-x86_64-extras-rpms"
#    "rhel-8-for-x86_64-highavailability-rpms"
#    "rhel-8-for-x86_64-rt-rpms"
#    "rhel-8-for-x86_64-supplementary-rpms"
#)


# Liste des depots officiel