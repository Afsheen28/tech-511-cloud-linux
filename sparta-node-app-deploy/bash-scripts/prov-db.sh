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
   sudo DEBIAN_FRONTEND=noninteractive gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
echo Done!
echo

echo create list file for mongodb
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
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

#backup mongod.conf
echo Backing up /etc/mongod.conf
sudo cp /etc/mongod.conf /etc/mongod.conf.bak
echo Backup complete!
echo

#use sed to change bindIp
echo Updating bindIp from 127.0.0.1 to 0.0.0.0...
sudo sed -i 's/bindIp: 127\.0\.0\.1/bindIp: 0.0.0.0/' /etc/mongod.conf
echo Done!
echo


#use sed command to edit /etc/mongod.conf, change bindIp from 127.0.0.1 to 0.0.0.0

echo Start Mongodb
sudo systemctl start mongod
echo Done
echo

echo enable mongod
sudo systemctl enable mongod
echo Done!
echo

#localhost: 127.0.0.1. Computer talks to itself. Lookback address.




#!/bin/bash

# Purpose: Provision MongoDB v7 for Sparta test app
# Tested on: Ubuntu 22.04 LTS
# Idempotent: Yes (safe to rerun)
# Author: Afsheen
# Last Tested: 19/09/2025

set -e

echo "=== Updating system ==="
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y -q

echo "=== Installing prerequisites ==="
sudo apt install -y gnupg curl

echo "=== Adding MongoDB GPG key and repo ==="
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] \
https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

echo "=== Installing MongoDB 7.0 ==="
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt install -y mongodb-org

echo "=== Backing up and updating mongod.conf ==="
sudo cp /etc/mongod.conf /etc/mongod.conf.bak || true
sudo sed -i 's/bindIp: 127\.0\.0\.1/bindIp: 0.0.0.0/' /etc/mongod.conf

echo "=== Enabling and starting MongoDB ==="
sudo systemctl enable mongod
sudo systemctl restart mongod

echo "=== MongoDB setup complete! ==="
