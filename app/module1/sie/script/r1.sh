echo "Conformément à la politique de durcissmenet"
echo "Voici la liste des services installé merci de verifier que uniquement les services nécessaires sont utilisés"
sleep 3
clear
systemctl list-units --type=service >/tmp/module1/output/service_installe 


# jacquemart listes services interdits SI ON PEUT