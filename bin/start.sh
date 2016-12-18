#!/bin/bash
while true; do
    read -p "Voulez vous remplir la base de données de test ?" yn
    case $yn in
        [Yy]* ) cd bin/; coffee metric.coffee; cd ..; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
cd bin/
echo ----------
echo
echo Execution des tests
echo
echo ----------
sh test.sh
cd ..
cd src/
echo ----------
echo
echo Si vous avez rempli la base de données via ce script vous y trouverez les users:
echo user: caro     password: 123
echo user: gaby     password: azerty
echo
echo ----------
nodemon app.coffee
