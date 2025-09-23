# add sed to replace file with another file. E.g. ip address


#For reverse proxy app:

* Make sure you are in the correct file path
* When you have to start the instance again, the IP address changes. This means you need to change the DB_HOST by entering this command: export DB_HOST=mongodb://34.245.99.163:27017/posts

* After that, type this: sudo sed -i 's|try_files.*|proxy_pass http://127.0.0.1. This replaces the port 3000 with just the IP address.
  
* Then do sudo systemctl restart nginx. This restart the app after all the updates.

* Finally, do npm install to get the database connected and the records seeded again.

* pm2 start app.js to start app and refresh the page. 



Automation Notes:

* When creating images, remember it is going to be stored on the disk. 
* When an AMI get created, in order for the database to work, it temporatily shuts down the VM and then opens it again. 
* This happens when it copies the disk. 
* We get a 502 gateway error beacuse the port 3000 is trying to run the app but the app is not working right now. So the nginx which is working in port 80,     transfers traffic to port 3000 during the reverse proxy, But since the app is not running, we get the gateay error. 

# ----------------------------------------------------------------------------------------------------------------------

AMI User data:
#!/bin/bash

cd /home/ubuntu/repo/app

export DB_HOST=mongodb://publicIP_DB/posts

pm2 start app.js

# --------------------------------------------------------------------------------------------------------------------

Why do we use pm2?




Why do we use nginx?

* When running both app and db prov scripts, make sure to get the db running first. This is because you need to be able to get the database running and active before getting the app to run. This is so that the /posts page get to start.
* When making the environmental variable persistent, make sure you add the private IP of the DB VM. 

