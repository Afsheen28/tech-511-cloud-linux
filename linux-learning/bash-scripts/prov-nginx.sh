#!/bin/bash

#update
sudo apt update
#upgrade - asks for user input - FIX!
sudo apt upgrade -y
#install nginx - asks for user input - FIX!
sudo apt install nginx -y
#restart nginx
sudo systemctl restart nginx
#enable nginx
sudo systemctl enable nginx