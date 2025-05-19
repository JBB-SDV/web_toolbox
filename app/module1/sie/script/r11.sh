#!/bin/bash

output=$(find /home/jb/Desktop/project/ICAR/mod1/script_dur/stp -type f \( -nouser -o -nogroup \) -ls 2>/dev/null)

if [ -n "$output" ]; then
  echo -e "\n Attention, ces fichiers ne sont pas rattachés à un utilisateur ou un groupe \n   "
  echo "$output"
else
  echo "Aucun fichier sans utilisateur ou groupe trouvé"
fi

# CHANGER LE FIND
# Pour teste
# Appartient a l'user root      sudo chown 1:1 filename.txt  
# Appartient a aucun user       sudo chown 9999:9999 filename.txt                                                                                                                                                  ─╯
