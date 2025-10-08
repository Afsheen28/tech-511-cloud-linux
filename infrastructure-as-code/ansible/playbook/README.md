# Playbook Ansible tasks

## Task 1: Create and run playbook to provision app VM
## Stage 1
* Created a playbook named "prov_app_with_npm start.yaml".
* Task was to run the app with npm start.
* Cloned the repository and used npm start to run the app however found that npm start takes the control away from the "controller" VM, and hangs the machine. Hence best practice is to use pm2. 
* Make sure you do "sudo nano hosts" to change the IP address of the target app node and target db node if necessary.
* To make sure that the "controller" VM, has the established connection within the target app node and the target db node, do "ansible web -m ping". If you get a "success" message it means that the "Controller" VM has successfully been able to establish the connection between the app node and db node.
* To run the YAML file, command line is "anisble-playbook nameoffile.yaml".
* Once all tasks are complete, click the public IP address of the app node VM and check if the app is working.
* Make sure it is HTTP and after the IP address, follow with a :3000.

Blockers/errors:
* While cloning the app folder, i couldn't get it to work even though I used code from google following a website on how to do it. Apparently, I needed to convert the Bash scipt line of cloning the repository into YAML.
* NodeJs was not installing properly. After installation, when I tried running the script again, it said the previous version of Node was clashing and not able to execute the tasks and run the app. I had to add extra lines of code where it deletes the previous versions of Node and installs the latest version before starting the app. 
* Due the connection timeout from my instance in Gitbash, I didn't realise my file path had been removed and tried running the app from the directory where the app folder was not in. After I realised, I connected back to the right file path but when I tried running the YAML script again, it said that there is already a process using :3000. This meant that I now had to SSH into the app target node VM and then find the process and kill it using the brute force command (sudo kill -9 idnum) before coming back to the "Controller" VM and running the script again. 

## Stage 2
* For this task, you need to allow pm2 to start the app in the background without npm start as it holds the execution back. This means you need to take out the npm start lines of code. 
* Once you have your script, paste the script, after "sudo nano nameoffile.yaml". 
* Then run it on the "Controller" VM, by doing "ansible-playbook nameoffile.yaml".
* Once all the tasks are done, SSH into the app target node and run "pm2 list" to see if the app is running. If it says online, go to the public IP address and check if it is working.
Blockers/ errors:
* I had run the app with npm start and forgot to kill the process so the app was running but using npm start on port 3000.
* I had to SSH into the app VM and kill the process (sudo lsof -i :3000) before re-trying the command "pm2 list" to see if it works.
* Once I deleted the process (sudo kill -9 pid) and ran sudo pm2 list to see if it was working, it did. 
* The app was working in the root directory which is why I had to use sudo.

## Stage 3
* Remember to kill the process from the previous task by SSH'ing into the app VM and 
* For this task, you need to make sure you are using nginx, pm2 and npm. Even though pm2 runs the app in the background, you need to make sure that you have cloned the repository.
* I had to create a task where I had to get the reverse proxy working by removing the need to use port 3000.
blockers/errors:
* Many errors I had was because there was already a cloned repo with a name and when running the script it couldn't clone since there was already something inside. 
* I complicated the code a lot which made it really confusing.
* Once the YAML ran with no errors, I had to run the website and it worked but with no Sparta logo. Solution was to create a new app target node.