
#!/bin/bash

echo "Le sticky bit est un attribut de permission sous Unix/Linux qui empêche la suppression ou la modification d'un fichier par quelqu'un d'autre que son propriétaire, même si le répertoire est accessible en écriture à d'autres utilisateurs"
echo " Merci de verifier que les données suivantes n'ont pas la nécessité d'avoir le sticky bit activé !!" 
# Vérification des répertoires accessibles en écriture par tous sans sticky bit
echo "Recherche des répertoires modifiables par tous sans sticky bit..."
find / -type d \( -perm -0002 -a \! -perm -1000 \) -ls 2>/dev/null

# Vérification des répertoires accessibles en écriture par tous dont le propriétaire n'est pas root
echo "Recherche des répertoires modifiables par tous dont le propriétaire n'est pas root..."
find / -type d -perm -0002 -a \! -uid 0 -ls 2>/dev/null


