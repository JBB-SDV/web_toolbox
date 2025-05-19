#!/bin/bash

problems_found=0 

# Lire le fichier /etc/shadow avec sudo dans un seul processus
while IFS=: read -r user hash _; do
    if [[ -z "$hash" || "$hash" == "*" || "$hash" == "!" || "$hash" =~ ^! ]]; then # uniquement compte user 
        continue
    fi

    # Décomposer le hash ($id$sel$hash)
    IFS='$' read -r _ id sel hachage <<< "$hash"

    case "$id" in
        5) algo="SHA-256" ;;
        6) algo="SHA-512" ;;
        *) 
            echo "Utilisateur: $user → Algorithme non sécurisé ou inconnu"
            problems_found=$((problems_found + 1))
            continue
            ;;
    esac
done < <(cat /etc/shadow)
echo -e "\n"
echo -e "Remédiation ! \n\n"
if [[ "$problems_found" -gt 0 ]]; then
    echo " Certains utilisateurs ont des problèmes de sécurité."
    echo "➡️  Pour corriger :"
    echo "   - Utilisez SHA-512 avec un sel : passwd -e <utilisateur>"
    echo "   - Vérifiez que les rounds dans /etc/login.defs et PAM (/etc/pam.d/common-password)"
    echo "       Pour /common-password"
    echo "          password required pam_unix.so sha512 rounds=65536"
    echo "       Pour /common-password"
    echo -e "       ENCRYPT_METHOD SHA512 \n       SHA_CRYPT_MIN_ROUNDS 65536 \n       SHA_CRYPT_MAX_ROUNDS 90000" 
else
    echo "Tous les comptes sont correctement sécurisés !"
fi