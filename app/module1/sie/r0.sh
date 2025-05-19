#!/bin/bash
i=0
echo "Test que la politique de duricssement est bien appliqué."
mkdir /tmp/module1/output

for script in /tmp/module1/script/r1.sh /tmp/module1/script/r13-r2.sh /tmp/module1/script/r3.sh /tmp/module1/script/r4.sh /tmp/module1/script/r5.sh /tmp/module1/script/r6.sh /tmp/module1/script/r7.sh /tmp/module1/script/r8.sh /tmp/module1/script/r9.sh /tmp/module1/script/r10.sh /tmp/module1/script/r11.sh 
#/tmp/module1/script/r12.sh
do
    i=$((i+1))  
    /$script > /tmp/module1/output/output_r$i 
    sleep 2
    
done
#cp app/module1/output/output_r2 app/module1/output//output_r13
echo -e " Merci d'avoir pris le temps de vouloir vous tester sur votre SI \n"
echo -e " Vous pouvez voir le résultat de chaque scan dans le dossier output \n"
echo -e " Maitenant il est requis d'appliquer les correctifs puis de re tester."
#clear
python3 /tmp/module1/parseur.py


