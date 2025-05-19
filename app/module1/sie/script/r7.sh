echo "Conformément à la politique de durcissmenet"
echo "Voici la liste des services actives merci de verifier que uniquement les services nécessaires sont utilisés"
systemctl list-units --type=service --state=running > /tmp/module1/output/service_active 


# jacquemart listes services interdits SI ON PEUT

