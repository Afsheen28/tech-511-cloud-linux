# Manually deploy the app
scp = secure copy 
* Using scp

* scp = secure copy, good for one-time transfers.

* Command format:
* scp -i /path/to/key.pem /path/to/local/file.zip ec2-user@<EC2-PUBLIC-IP>:/home/ec2-user/

* Example:
scp -i ~/keys/mykey.pem ~/projects/mycode.zip ec2-user@3.85.210.12:/home/ec2-user/


* -i ~/keys/mykey.pem → your private key.

* ~/projects/mycode.zip → the zip file on your local machine.

* ec2-user@3.85.210.12:/home/ec2-user/ → login user and destination.

* On Ubuntu instances use ubuntu@....

* On Amazon Linux instances use ec2-user@....

* Then, on your VM:

* unzip mycode.zip


blocker: 
* http not https
* And make sure port is saved as 3000 in security group tab.  

# Task: Finish Bash script to provision & run app in the background using &

* Last login: Tue Sep 16 15:22:43 2025 from 45.150.146.89
* ubuntu@ip-172-31-17-249:~$ ls
* README.md  nodejs20-sparta-test-app      nodesource_setup.sh
* app        nodejs20-sparta-test-app.zip
* ubuntu@ip-172-31-17-249:~$ cd app
* ubuntu@ip-172-31-17-249:~/app$ ls
* README.md  models        package-lock.json  public  test
* app.js     node_modules  package.json       seeds   views
* ubuntu@ip-172-31-17-249:~/app$ nohup app.js > app.log 2>&1 &
* [1] 10504
* ubuntu@ip-172-31-17-249:~/app$ nohup node app.js > app.log 2>&1 &
* [2] 10506
* [1]   Exit 127                nohup app.js > app.log 2>&1
* ubuntu@ip-172-31-17-249:~/app$ ps aux | grep node
* ubuntu     10506  1.5  6.5 1019372 61476 pts/0   Sl   15:49   0:00 node * app.js
* ubuntu     10514  0.0  0.2   7008  2432 pts/0    S+   15:49   0:00 grep * --color=auto node
* ubuntu@ip-172-31-17-249:~/app$ tail -f app.log
* nohup: ignoring input
* Your app is ready and listening on port 3000

