#!/bin/bash
while true; do
    read -p "Voulez vous remplir la base de données de test ?" yn
    case $yn in
        [Yy]* ) cd bin/; coffee metric.coffee; cd ..; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
cd bin/
sh test.sh
cd ..
cd src/
echo **********
echo
echo Si vous avez remplit la base de données via ce script vous y trouverai les users:
echo user: caro     password: 123
echo user: gaby     password: azerty
echo
echo **********
nodemon app.coffee
