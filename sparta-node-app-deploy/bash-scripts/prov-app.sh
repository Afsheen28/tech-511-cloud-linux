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

#reverse proxy 
echo Reverse proxy using sed command...
sudo sed -i 's|try_files.*|proxy_pass http://127.0.0.1:3000;|' /etc/nginx/sites-available/default
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
npm install #triggers node seeds/seed.js
echo Done!
echo

echo Start app in background...
nohup node app.js > app.log 2>&1 &
echo App started in background!

#Get app code using git clone 
echo install git
sudo apt-get install git
echo Done!
echo

#copy url
echo copy repo url using https
git clone https://github.com/Afsheen28/tech511-sparta-app.git
echo Done!
echo

#move into repo
echo move into repo
cd tech511-sparta-app/app
echo Done!
echo

#copy app folder into repo
echo copy app folder into repo
cp -r ~/tech511-sparta-app/app ~/
echo Done!
echo

#Asked for a username and password
#username:Afsheen28
#password: Personal Access Token


#cd into app folder

#set env var DB_HOST
export DB_HOST=mongodb://3.250.235.92:27017/posts #(IP of db vm will change everytime)

#run npm install

#run app in background with pm2

sudo npm install -g pm2
pm2 logs tech511-sparta-app
app pm2 logs tech511-sparta-app
pm2 start app.js --name tech511-sparta-app
pm2 list
pm2 stop tech511-sparta-app
pm2 restart tech511-sparta-app
pm2 startup systemd
app pm2 save
pm2 logs tech511-sparta-app

#ubuntu@ip-172-31-42-26:~$ cd ~/tech511-sparta-app/app
#ubuntu@ip-172-31-42-26:~/tech511-sparta-app/app$ export DB_HOST=mongodb://172.31.35.61:27017/posts
#ubuntu@ip-172-31-42-26:~/tech511-sparta-app/app$ node seeds/seed.js
#Connected to database
#Database cleared
#Database seeded with 100 records
#Database connection closed
#Means database connection works


#--------------------------------------------------------------------------------------------------------------

#!/bin/bash

# Purpose: Provision Node.js and Sparta test app
# Tested on: Ubuntu 22.04 LTS
# Idempotent: Yes (safe to rerun)
# Author: Afsheen
# Last Tested: 19/09/2025

set -e

APP_DIR=~/tech511-sparta-app/app
DB_HOST="mongodb://172.31.56.172/posts"  # REPLACE with your DB VM private IP

echo "=== Updating system ==="
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y -q

echo "=== Installing prerequisites ==="
sudo apt install -y curl git

echo "=== Installing Node.js v20 ==="
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "=== Installing PM2 globally ==="
sudo npm install -g pm2

echo "=== Cloning Sparta app repo ==="
if [ ! -d "$APP_DIR" ]; then
  git clone https://github.com/Afsheen28/tech511-sparta-app.git ~/tech511-sparta-app
fi

echo "=== Moving into app directory ==="
cd $APP_DIR

echo "=== Setting DB_HOST environment variable ==="
export DB_HOST=$DB_HOST

echo "=== Installing dependencies and seeding DB ==="
npm install

echo "=== Starting app with PM2 ==="
pm2 start app.js --name tech511-sparta-app || pm2 restart tech511-sparta-app --update-env

echo "=== Saving PM2 process list ==="
pm2 save
pm2 startup systemd -u ubuntu --hp /home/ubuntu

echo "=== App setup complete! Visit http://34.241.195.159:3000/posts ==="

