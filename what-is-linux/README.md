
- [Why is managing file ownership important?](#why-is-managing-file-ownership-important)
- [What is the command to view file ownership?](#what-is-the-command-to-view-file-ownership)
- [What permissions are set when a user creates a file or directory? Who does file or directory belong to?](#what-permissions-are-set-when-a-user-creates-a-file-or-directory-who-does-file-or-directory-belong-to)
- [Why does the owner, by default, not receive X permissions when they create a file?](#why-does-the-owner-by-default-not-receive-x-permissions-when-they-create-a-file)
- [What command is used to change the owner of a file or directory?](#what-command-is-used-to-change-the-owner-of-a-file-or-directory)
- [Does being the owner of a file mean you have full permissions on that file? Explain.](#does-being-the-owner-of-a-file-mean-you-have-full-permissions-on-that-file-explain)
- [If you give permissions to the User entity, what does this mean?](#if-you-give-permissions-to-the-user-entity-what-does-this-mean)
- [If you give permissions to the Group entity, what does this mean?](#if-you-give-permissions-to-the-group-entity-what-does-this-mean)
- [If you give permissions to the Other entity, what does this mean?](#if-you-give-permissions-to-the-other-entity-what-does-this-mean)
- [You give the following permissions to a file: User permissions are read-only, Group permissions are read and write, Other permissions are read, write and execute. You are logged in as the user which is owner of the file. What permissions will you have on this file? Explain.](#you-give-the-following-permissions-to-a-file-user-permissions-are-read-only-group-permissions-are-read-and-write-other-permissions-are-read-write-and-execute-you-are-logged-in-as-the-user-which-is-owner-of-the-file-what-permissions-will-you-have-on-this-file-explain)
- [Here is one line from the ls -l. Work everything you can about permissions on this file or directory.](#here-is-one-line-from-the-ls--l-work-everything-you-can-about-permissions-on-this-file-or-directory)
- [What numeric values are assigned to each permission?](#what-numeric-values-are-assigned-to-each-permission)
- [What numeric values would you use to assign read + write permissions?](#what-numeric-values-would-you-use-to-assign-read--write-permissions)
- [What numeric values would you use to assign read, write and execute permissions?](#what-numeric-values-would-you-use-to-assign-read-write-and-execute-permissions)
- [What numeric values would you use to assign read and execute permissions?](#what-numeric-values-would-you-use-to-assign-read-and-execute-permissions)
- [Often, a file or directory's mode/permissions are represented by 3 numbers. What do you think 644 would mean?](#often-a-file-or-directorys-modepermissions-are-represented-by-3-numbers-what-do-you-think-644-would-mean)
- [What command changes file permissions?](#what-command-changes-file-permissions)
- [To change permissions on a file what must the end user be? (2 answers)](#to-change-permissions-on-a-file-what-must-the-end-user-be-2-answers)
- [Give examples of some different ways/syntaxes to set permissions on a new file (named testfile.txt) to:](#give-examples-of-some-different-wayssyntaxes-to-set-permissions-on-a-new-file-named-testfiletxt-to)
- [Set User to read, Group to read + write + execute, and Other to read and write only](#set-user-to-read-group-to-read--write--execute-and-other-to-read-and-write-only)
- [Add execute permissions (to all entities)](#add-execute-permissions-to-all-entities)
- [Take write permissions away from Group](#take-write-permissions-away-from-group)
- [Use numeric values to give read + write access to User, read access to Group, and no access to Other.](#use-numeric-values-to-give-read--write-access-to-user-read-access-to-group-and-no-access-to-other)



### Why is managing file ownership important?

* Linux is a multi-user OS.
* File ownership controls who can access or modify files.
* Prevents unauthorised access and protect system stability (e.g., stopping normal users from changing /etc/passwd).
* To find linux version: uname -a.

### What is the command to view file ownership?

ls - l
ls -ln: used when user/group name not available. 

### What permissions are set when a user creates a file or directory? Who does file or directory belong to?

* New files start with mode 666 (rw-rw-rw-) before umask is applied.
  
* New directories start with mode 777 (rwxrwxrwx) before umask is applied.

* Then umask subtracts bits (it's a mask of bits to remove).

* Ownership: File belongs to the user who created it and their primary group.

* Permissions: Determined by the umask value.

* Default umask is usually 0022.

That results in:

* Files: rw-r--r-- (644) → Owner can read/write; group/others can read.

* Directories: rwxr-xr-x (755) → Owner full control; group/others can read/enter.

### Why does the owner, by default, not receive X permissions when they create a file?

* x = execute permission (treats file as a program/script).

* By default, new files are assumed to be data, not executables.

* Prevents security issues where every new file would automatically be runnable.

You can make a file executable manually:

chmod +x script.sh


### What command is used to change the owner of a file or directory?

* chmod changes file permissions

* Use chown: changes owner and optionally group

* Change owner: chgrp changes only the group

sudo chown bob file.txt


* Change owner and group:

sudo chown bob:staff file.txt


* Recursively change ownership of a folder and its contents:

sudo chown -R bob:staff myfolder/


 ### Does being the owner of a file mean you have full permissions on that file? Explain.

* No. Being the owner means you can change the file’s permissions (using chmod) or transfer ownership (if you’re root).

* But you only have the permissions that are explicitly granted in the User (owner) section of the file’s permission bits.

* Example: If the file is -r--r--r--, even the owner only has read access.

### If you give permissions to the User entity, what does this mean?

* The User entity = the file’s owner.

* Permissions here apply only to the user who owns the file.


### If you give permissions to the Group entity, what does this mean?

* The Group entity = applies to all users who are members of the file’s group.

* They share whatever permissions are set under the “group” column.

* E.g. chmod g+r filename.txt means that everyone in the file's group can read the file.

### If you give permissions to the Other entity, what does this mean?

* The Other entity = applies to all other users on the system (not the owner, not in the group).

* Typically the most restrictive, since it covers "everyone else."

* e.g. chmod o+x file.sh lets any user on the system execute the file. 

### You give the following permissions to a file: User permissions are read-only, Group permissions are read and write, Other permissions are read, write and execute. You are logged in as the user which is owner of the file. What permissions will you have on this file? Explain.

I will have read-only access, because Linux checks your identity first:

* Am I the owner? → Yes → use User permissions (r--).

* It doesn’t matter if Group or Other has more permissions — the system doesn’t fall back to them.

* So as owner, you cannot write or execute, only read.

### Here is one line from the ls -l. Work everything you can about permissions on this file or directory.

-rwxr-xr-- 1 tcboony staff  123 Nov 25 18:36 keeprunning.sh

File type & permissions:

* → regular file

* rwx → User (owner) has read, write, execute

* r-x → Group has read & execute, no write

* r-- → Others have read-only

Links: 1 → only one hard link (the file itself).

Owner: tcboony → user who owns the file.

Group: staff → group that owns the file.

Size: 123 bytes.

Date/time modified: Nov 25 18:36.

Filename: keeprunning.sh.

* Likely a shell script (.sh).

* Because it has execute (x) permission for the owner and group, it can be run as a program.

In conclusion: 
* Owner (tcboony): full access (read/write/execute).

* Group (staff): read & execute only.

* Others: read-only.

### What numeric values are assigned to each permission?
* Read (r) = 4
* Write (w) = 2
* Execute (x) = 1
* No permission = 0
### What numeric values would you use to assign read + write permissions?
Read + Write (rw-) = 4 + 2 = 6 
### What numeric values would you use to assign read, write and execute permissions?
Read + Write + Execute (rwx) = 4 + 2 + 1 = 7
### What numeric values would you use to assign read and execute permissions?
Read + Execute (r-x) = 4 + 1 = 5
### Often, a file or directory's mode/permissions are represented by 3 numbers. What do you think 644 would mean?
* 1st digit = Owner Permissions
* 2nd digit = Group Permissions
* 3rd digit = Other (everyone else) permissions 

* Owner = 6 = read (4) + write (2) → rw-

* Group = 4 = read only → r--

* Others = 4 = read only → r--

So 644 means:

* Owner can read and write

* Group can only read

* Others can only read

### What command changes file permissions?
chmod

### To change permissions on a file what must the end user be? (2 answers)
* The owner of the file.
* Or the superuser (root) 
### Give examples of some different ways/syntaxes to set permissions on a new file (named testfile.txt) to:
### Set User to read, Group to read + write + execute, and Other to read and write only
chmod u=r, g=rwx, o=rw testfile.txt
### Add execute permissions (to all entities)
chmod a+x testfile.txt
### Take write permissions away from Group
chmod g-w testfile.txt
### Use numeric values to give read + write access to User, read access to Group, and no access to Other.
User: read(4) + write (2) = 6
Group: read (4) = 4
Other: none (0)

chmod 640 testfile.txt
