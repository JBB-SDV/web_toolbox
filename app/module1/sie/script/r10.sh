last > /tmp/module1/output/last_activity
echo "Liste des users sur la machine" > /tmp/module1/output/user_machine
awk -F: '$3 >= 1000 {print $1}' /etc/passwd >> /tmp/module1/output/user_machine
while read user; do
    grep "^$user" /tmp/module1/output/last_activity | head -n1 >> /tmp/module1/output/last_connexion
done < /tmp/module1/output/user_machine
echo "Dernière connexion des utilisateurs" >> /tmp/module1/output/last_connexion
echo "Merci d'éviter les utilisateurs inactif !!" >> /tmp/module1/output/last_connexion



