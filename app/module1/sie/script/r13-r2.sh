
# R2 
# Ainsi il faut :
#- désactiver la connexion par mot de passe en ssh
#- désactiver la connexion root en direct depuis 

# R13
#Sous OpenSSH, les directives suivantes doivent être rajoutées dans le sshd_config et le ssh_config :
#Ciphers aes256-ctr,aes192-ctr,aes128-ctr
# Pour les versions 6.3+, OpenSSH supporte le ETM (encrypt-then-mac),
# plus sûr que les anciennes implémentations (mac-then-encrypt)
#  "hmac-sha1" est obsolète et doit être supprimé (tester la compatibilité de cette mesure avec Passage PP)
#MACs hmac-sha2-512,hmac-sha2-256


test=0
if ! cat /etc/ssh/sshd_config | grep "PermitRootLogin yes" > /dev/null ; then
    echo "La connexion avec le compte root en ssh doit être désactivé !"
    test=$((test + 1))
    
fi

if  ! cat /etc/ssh/sshd_config | grep "PasswordAuthentication yes" > /dev/null; then
    
    echo "La connexion par mot de passe doit être désactivée, l'utilisation de ssh doit ce faire par mot de passe !"
    test=$((test + 1))
fi


if ! cat /etc/ssh/ssh_config | grep "Ciphers aes256-ctr,aes192-ctr,aes128-ctr" > /dev/null; then
    echo "Cette ligne doit être rajouté ou modifé dans votre config openSSH conformément au socle de durcisment"
    echo -e "Ciphers aes256-ctr,aes192-ctr,aes128-ctr\n"
    test=$((test + 1))
fi


if ! cat /etc/ssh/ssh_config | grep "MACs hmac-sha2-512,hmac-sha2-256" > /dev/null; then
    echo "Cette ligne doit être rajouté ou modifé dans votre config openSSH conformément au socle de durcisment"
    echo -e "MACs hmac-sha2-512,hmac-sha2-256\n"
    test=$((test + 1))
fi


# If no issues were found
if [ $test -eq 0 ]; then
    echo "Votre configuration de connexion ssh correspond aux normes demandées"
fi

