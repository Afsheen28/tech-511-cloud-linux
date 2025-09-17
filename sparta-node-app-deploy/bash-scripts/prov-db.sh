#!/bin/bash

#Purpose: Provision mongo database v7 for Sparta test app
#Tested on: AWS, Ubunti 22.04 LTS
#Planning for it to work on: New VM and idempotent
#Tested by: Afsheen
# Tested when: 17/9/25


echo Update...
sudo DEBIAN_FRONTEND=noninteractive
sudo apt update 
echo Done!
echo 

echo Upgrade...
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y -q
echo Done!
echo 


# echo install gnupg and curl
# sudo apt-get install gnupg curl
# echo Done!
# echo

echo Get gpg key for mongodb
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
echo Done!
echo

echo create list file for mongodb
echo echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
echo Done!
echo

echo update packages list
sudo apt-get update
echo Done!
echo


echo install mongodb community server
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
   mongodb-org=7.0.22 \
   mongodb-org-database=7.0.22 \
   mongodb-org-server=7.0.22 \
   mongodb-mongosh \
   mongodb-org-shell=7.0.22 \
   mongodb-org-mongos=7.0.22 \
   mongodb-org-tools=7.0.22 \
   mongodb-org-database-tools-extra=7.0.22
echo Done!
echo

#use sed command to edit /etc/mongod.conf, change bindIp from 127.0.0.1 to 0.0.0.0

echo Start Mongodb
sudo systemctl start mongod
echo Done
echo

echo enable mongod
echo systemctl enable mongod
echo Done!
echo





#localhost: 127.0.0.1. Computer talks to itself. Lookback address.