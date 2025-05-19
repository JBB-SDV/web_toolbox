cat /etc/pam.d/common-password | grep "password	requisite			pam_pwquality.so retry=3 minlen=14 difok=4" || echo "Attention la politque de mot de passe n'est pas appliqué !!" 
echo " La politque de mot de passe doit comporter 14 caracèteres et 4 caracèteres différent"
echo -e " Voici une regle PAM avec les parametres requis \n"
echo "password    requisite            pam_pwquality.so retry=3 minlen=14 difok=4"




# /etc/pam.d/system-auth redhat 
#retry=3 : autorise trois essais pour la saisie du mot de passe ;
#minlen=12 : détermine la longueur minimale d’un mot de passe ;
#difok=3 : indique le nombre de caractères qui doivent être différents entre un ancien et un nouveau mot de passe.










# Verifie dans les files de configs directment ?
