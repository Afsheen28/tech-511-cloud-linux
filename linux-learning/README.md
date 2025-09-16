#Linux

- [Why learn Linux?](#why-learn-linux)
- [What is Linux?](#what-is-linux)
- [What is Bash?](#what-is-bash)
- [What is a shell?](#what-is-a-shell)
- [Diff between home and root directories](#diff-between-home-and-root-directories)
- [Walkthrough Commands](#walkthrough-commands)
  - [Bash script to install nginx](#bash-script-to-install-nginx)
- [Manage Processes](#manage-processes)
  - [What is a process?](#what-is-a-process)

## Why learn Linux?

* Open-source and adaptable/flexible
* Inexpensive
   * RedHat Enterprise version of Linux - costs
* Fast-growing
* Stable
* Scales well to sever tasks
* Becoming more popular for desktop/workstation use
* Often used in DevOps
  
## What is Linux?

* Spinoff of Unix
* Made of Kernel (core OS), plus many libraries & utilities that rely on that Kernel.
* Many different distributions

## What is Bash?
Stands for Bourne Again Shell
* Type of Shell
* The most commonly used Shell in Linux
* Stored at: /bin/bash

## What is a shell?
Software/interface that runs the commands.
* In Linux, there are a range of Shells available.
* Software/ Interface that runs the commands.
* In Linux, there are a range of shell available.

## Diff between home and root directories
Home directory
* The user's personal author
 * The user's personal folder
 Default is you are taken straight there when you login.
On Linux, found here: 
```
/home/<user's folder>
```

Root directory: "final parent" in the files/folder structure
if you start a file/folder path with '/', you are saying the path starts in the root directory. 

## Walkthrough Commands

* After putting ssh command in gitbash, you find the version by doing "uname -v"
* "whoami" command says who you are.
* cat /etc/shells: shows the path of all the available shell on the computer.
* ps -p $$: a list of all processes that are currently running on your system.
* history: you can see all the previous commands
* up arrow: get previous commands
* !(numofcommand): runs the command
* ls -a: lists all the files in the directory including all the hidden files.
* ls: lists all the files in the directory
* pwd: lists the working directory. When printed /, means home dircetory.
* ls -l: lists and counts the directory/files
* ls- al: lists and counts the hidden files
* . means current folder
* .. means going back/ up the heiarchy
* cd takes you directly to your home directory
* do ls after every command to verify if it's worked. 
* Anything hidden start with a . .
* wget https://cdn.britannica.com/39/7139-050-A88818BB/Himalayan-chocolate-point.jpg -O cat2.jpg 
* file (filename) shows what type of file it is. 
* cp cat.jpg cat.txt means that it saves another file with new extention
* rm cat.txt: removes files. DANGEROUS!
* mkdir = make directory
* Don't enter space when naming files else they would be created as separate files.
* -r: removes directories and their contents recursively.
* -d: deleted empty directories.
* touch creates a new empty file.
* nano or vim are text editors.
* nano (filename) opens textfile with file name. 
* ctrl s + ctrl x. Saves and exits file.
* cat filename.txt prints the whole file into GitBash.
* head -(number of lines) filename.txt
* tail -(number of lines) filename.txt
* nl filename.txt
* cat chicken-joke.txt = to see if there is text in the file.
* cat filename.txt | grep word = searches a specific word in the file.
* sudo apt install tree : lists the files and directory in a tree structure. 
* sudo apt update/ sudo apt-get update: just checks what's out there in terms of packages. 
* sudo apt upgrade -y : says yes when updating the verision of lunux packages. 
* sudo su = switch user. Gone to root. 
* mv command can move files to different folders but also rename them. 
* cp= copy files 
* / = root directory
* tilde/~ = home directory. 
* nano prov-nginx.sh opens bash terminal. 

* Bash is the shell that interprets with the user in terminal/CLI. 
* q for quit and ctrl+c for exit. (in status terminal for nginx)
* export is variable environment.
* A variable is used inside a script and called when needed. But if you need it as a client then it is an environment variable.
* Environment variable only get called from that specific bash shell. So if you open another instance, the variable will be gone.
* Source command can load configuration commands. Can load bash scripts without having to log back in.

### Bash script to install nginx
[prov-nginx.sh](bash-scripts/prov-nginx.sh)

## Manage Processes

### What is a process?
* A program that loads in RAM/memory and uses CPU when needed.
* When a process is run, a process ID is given (PID).
* To run the command, it is ps.
* Can log in to the same instance more than once. When used the ps command, you can see the ID is different.
* LIST ALL PROCESSES : ps aux (REMEMBER)
2 types of processes in Linux:
 * System
 * User 
* With 'top' command, it orders it by CPU storage.
* memory uiltised - press M
* PID - press N (by newest at the top)
* CPU - press P
* sleep - makes terminal sleep for a few seconds
* sleep second & - makes terminal sleep in the background. Doesn't stop tasks/jobs from running. 
* To kill sleep: kill -1 PID
* Meduim kill: kill PID (not standard level)
* Brutal kill: kill -9 PID
* pm2 process: manages the running of certain apps
* Node app uses pm2 to run app. 
* If you do a brutal kill, you may be in risk of a zombie process since it can kill the parent process but still kill the child kill. 
