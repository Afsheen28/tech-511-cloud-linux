# add sed to replace file with another file. E.g. ip address


#For reverse proxy app:

* Make sure you are in the correct file path
* When you have to start the instance again, the IP address changes. This means you need to change the DB_HOST by entering this command: export DB_HOST=mongodb://34.245.99.163:27017/posts

* After that, type this: sudo sed -i 's|try_files.*|proxy_pass http://127.0.0.1. This replaces the port 3000 with just the IP address.
  
* Then do sudo systemctl restart nginx. This restart the app after all the updates.

* Finally, do npm install to get the database connected and the records seeded again.

* pm2 start app.js to start app and refresh the page. 