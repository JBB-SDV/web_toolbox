clear
echo "Merci de verifier que "
echo "Tous les services réseau doivent être en écoute sur les interfaces réseau adéquates."
echo "Liste des services réseau étant en écoute actuelllement \n "
ss -tulnp | head -n 1 && ss -tulnp | grep "LISTEN"