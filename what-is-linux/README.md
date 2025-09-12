
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



### Why is managing file ownership important?

* Linux is a multi-user OS.
* File ownership controls who can access or modify files.
* Prevents unauthorised access and protect system stability (e.g., stopping normal users from changing /etc/passwd).


### What is the command to view file ownership?

ls - l


### What permissions are set when a user creates a file or directory? Who does file or directory belong to?

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

* Use chown:

* Change owner:

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

### If you give permissions to the Other entity, what does this mean?

* The Other entity = applies to all other users on the system (not the owner, not in the group).

* Typically the most restrictive, since it covers "everyone else."

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