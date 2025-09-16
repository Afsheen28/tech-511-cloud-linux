#!/bin/bash

echo Update...
sudo apt update -y
echo Done!
echo 

#asks for user input - FIX!
echo Upgrade...
sudo apt upgrade -y
echo Done!
echo 

#asks for user input - FIX! 
echo Install nginx... 
sudo apt install -y nginx 
echo Done!
echo

#comfigure nginx
echo Restart nginx...
sudo systemctl restart nginx 
echo Done!
echo

echo Download script to install nod js v20
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