# Intro to Ansible

# What is Ansible?

* A configuration management tool - best for installing/configuring software.
* Red Hat leads development
* Open-source
* Written in Python
* Started with a few core modules that managed Linux servers
* Application deployment
* Works with almost any system
  * Linux & Windows servers
  * Routes and switches
  * Can configure Cloud services
  
## How does it work?
* Think of a recipe as a code and Ansible as a robot that follows the recipe.
* Recipes (the actions/tasks/instructions) are written in YAML called "playbooks".
* Ansible control node tells the target node what to do.
* agentless:
  * No need to install Ansible or any agents that needs to be installed in the target node that needs configuring.
  * Instead, using SSH to access target nodes and it also needs Python interpreter on Linux target nodes.

## How Ansible Architecture works:
![h](image.png)
* We will be having a "Controller" VM, and then 2 target nodes. Each target node will run one VM. One app VM and one DB VM.
* The "Controller" will all the software required to configure the target nodes.
* The "Controller" VM will be SSH'ing into both the VMs.
* In order to SSH, we need to give Ansible our private key.
* The "controller" VM will have 2 files names "playbooks" and "inventory"(not necessarily the name of the file) to allow the tasks to be done. The inventory will have a "host" file.
* To be able to tell us what the target nodes need to be able to configure, we have the private IP address that lets the app connect to the database.
* The playbooks will allow the target nodes (VMs) to run.
* To find the host file, it will be in `/etc/ansible`.
* The private key needed to SSH in will be put in a .SSH folder inside the "controller" VM. Path is `~/.ssh`.
* Both target node VM's will have to allow SSH as the security group from the controller VM. Make sure it is from the "Controller" only and not "from anywhere". Needs to allow port 22.

## Hosts file first entry

ec2-instance ansible_host=54.154.182.31 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/tech511-afsheen-aws.pem


* The pem file is used to SSH into the instances.
* The ping file is for knowing if the instance is live and responding.
* The ping command will make the "controller" VM SSH into the other instances and check if the communication between them is good. 
* On the controller VM, do the update and upgrade command: `sudo apt-get update -y` and `sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y`.
* Install Ansible repository into the "Controller VM" by doing `sudo apt-add-repository ppa:ansible/ansible`.
* Will need to update again so do the command `sudo apt-get update -y`.
* Install ansible with `sudo apt install ansible -y`.
* Check if ansible has been installed properly with `ansible --version`. Should be `[core 2.17.14]` or higher.
* cd into the ansible folder: cd /etc/ansible. 
* ls into the hosts file to allow the inventory to talk to the app and db target node VMs. 
* cd into the .SSH folder and you'll get back to the home directory. After that print out (using `cat filename`)  your PRIVATE SSH key and copy and paste it into the SSH file you created into the "Controller" VM.
![alt text](image-13.png)
* Allow read permissions to allow pem file to be accessed through the "Controller" VM:
  `chmod 400 tech511-afsheen-aws.pem`
* You will know that you have the pem file stored in the repo when you have 1600+ characters shown on the screen when you change the permissions.
* cd back into `/etc/ansible` and run `ansible all -m ping`.
* You get a "Warning: provided hosts lists is empty only localhost is available". This error means that there is no instances in the "host" file meaning that there is so successful connection between the target nodes and the "Controller" to send back a "pong".
* To enable connection do: `sudo nano hosts` and edit the file with the public IP addresses of each target node instance.
* At the top of the file, add a `web` group in square brackets.
* for the app node: `ec2-instance ansible_host=3.249.87.234 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/tech511-afsheen-aws.pem`
* for the db node: `ec2-instance ansible_host=3.249.87.234 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/tech511-afsheen-aws.pem`
* Change the public IP address of each accordingly.
* Now try `ansible all -m ping`.
* Should get green success message.


Some errors I got while doing this task was that I couldn't try to get Ansible installed until I typed in these commands: 
 * `sudo apt-get remove --purge -y ansible ansible-core`
 * `sudo apt-get autoremove --purge -y`
 * `sudo apt-get autoclean`
* THEN:
  * `sudo apt-get update -y`
  * `sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y`
  * `sudo apt-add-repository ppa:ansible/ansible`
  * `sudo apt-get update -y`
  * `sudo apt install ansible -y`

* ![alt text](image-1.png)
* ![](image-2.png)
* ![](image-3.png)
* ![alt text](image-4.png)
* ![alt text](image-5.png)
* ![alt text](image-6.png)
* ![alt text](image-7.png)
* ![alt text](image-8.png)
* ![alt text](image-9.png)
* ![alt text](image-10.png)
* ![alt text](image-11.png)
* ![alt text](image-12.png)
  

2nd Code along: 
* Ping is a module
* web is the group.
* Ad-hoc commands: 
* Quick one-off tasks that don't need playbooks to be written and run.
* ansible web -a "uname -a" : arguement command that specifies with a module. Is the equivalent to specify  
* ansible web -m ansible.builtin.command -a "uname -a" : Does the same thing as the command before.
* ansible web -m command -a "uname-a" does the same thing as previous 2. 
* Uses default/in built in command module if module is not specified in the command. 
* If you use Shell commands for the shell module, the command would not be idempotent(get the same result each time). This means configuration, deployment, etc.
*  Have to use different modules in the commands to allow to get Ansible idempotent. 
*  Don't use `shell` or `command` modules that are not idempotent. 
*  "ansible web -a "apt-get update -y" --become": is not idempotent but updates the target node (app VM).
*  ansible web -m apt -a "update_cache=yes" --become: idempotent command that updates the target node. 
*  ansible web -m ansible.builtin.apt -a "upgrade=dist" --become: upgrades the target node.
Create a playbook:
*  Check Ansible inventory for the current inventory you have. -> ansible-inventory --list
*  Make sure you don't have nginx installed: ansible web -a "systemctl status nginx" --become
* sudo nano install_nginx 
* ansible-playbook install_nginx.yaml -> to run the yaml file command
