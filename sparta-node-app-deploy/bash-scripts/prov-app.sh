#!/bin/bash

#Tested on: AWS, Ubunti 22.04 LTS
#Planning for it to work on: New VM and idempotent
#Tested by: Afsheen
# Tested when: 17/9/25



echo Update...
sudo DEBIAN_FRONTEND=noninteractive
sudo apt update 
echo Done!
echo 

#asks for user input - FIX!
echo Upgrade...
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y -q
echo Done!
echo 

#asks for user input - FIX! 
echo Install nginx... 
sudo apt install -y nginx 
echo Done!
echo

#configure nginx
echo Restart nginx...
sudo systemctl restart nginx 
echo Done!
echo

echo Download script to install node js v20
curl -sL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
echo Done!
echo

#asks for user input - FIX!
echo Run script to update things to install node js v20
sudo bash nodesource_setup.sh -y
echo Done!

#asks for user input - FIX!
echo install node js v20...
sudo apt install -y nodejs
echo Done!
echo

echo Move into app folder...
cd "C:\Users\affsi\Downloads\nodejs20-sparta-test-app\app"
echo Done!
echo

echo Install app dependencies...
npm install
echo Done!
echo

echo Start app in background...
nohup node app.js > app.log 2>&1 &
echo App started in background!

#Get app code using git clone 

#cd into app folder

#set env var DB_HOST
export DB_HOST=mongodb://54.194.224.43:27017/posts

#run npm install

#run app in background with pm2

