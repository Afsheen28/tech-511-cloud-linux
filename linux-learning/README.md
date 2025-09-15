#Linux

- [Why learn Linux?](#why-learn-linux)
- [What is Linux?](#what-is-linux)
- [What is Bash?](#what-is-bash)
- [What is a shell?](#what-is-a-shell)
- [Diff between home and root directories](#diff-between-home-and-root-directories)
- [Walkthrough Commands](#walkthrough-commands)

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
* tilde = home directory. 
* nano prov-nginx.sh opens bash terminal. 