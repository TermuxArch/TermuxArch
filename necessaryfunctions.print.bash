_PRINTUSAGE_() {
printf "\\n\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN" "  start Arch Linux in $TXPRQUON with root login.  This account is reserved for system administration.  Please use any system administrator account with care."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN c[ommand] command" "  run Arch Linux command from Termux as root login.  Quoting multiple commands can assit when passing multiple arguments:  " "$STARTBIN c 'whoami ; cat -n /etc/pacman.d/mirrorlist'" ".  Please pass commands through the system administrator account with caution."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN e[login|user] user" "  login as user.  Use alternate elogin and euser options to login as user.  This option is preferred for working with programs that have already been installed, and for working with the 'git' command.  Please use " "$STARTBIN c 'addauser user'" " first to create this user and the user's home directory."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN l[ogin]|u[ser] user" "  login as user.  This option is preferred when installing software from a user account with the 'sudo' command, and when using commands such as 'makeaurhelpers', 'makepkg' and 'makeyay'.  Please use 'addauser user' first to create this user and the user's home directory."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN r[aw]" "  construct the " "$STARTBIN " "proot statement from exec.../bin/.  For example " "$STARTBIN r su " "will exec su in Arch Linux.  Moreover, easy shell access is possible with this function:
~ $ startarch+x86_64 r bash
[root@localhost ~]# exit
exit
~ $ startarch+x86_64  r csh
# exit
exit
~ $ startarch+x86 r ksh
# exit
~ $ startarch+x86 r sh
sh-5.1# exit
exit
~ $ startarch r zsh
localhost# exit
See variable PROOTSTMNT for more options;  Please share your thoughts at https://github.com/SDRausty/TermuxArch/issues and https://github.com/SDRausty/TermuxArch/pulls."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n\\e[0m" "$STARTBIN s[u] user command" "  login as user and execute command.  This option is preferred when installing software from a user account with the 'sudo' command, and when using commands such as 'makeaurhelpers', 'makepkg' and 'makeyay'.  Quoting multiple commands can assit when passing multiple arguments:  " "$STARTBIN s user 'whoami ; cat -n /etc/pacman.d/mirrorlist'" ".  Please use " "$STARTBIN c 'addauser user'" " first to create a login and the login's home directory."
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN $@ 📲 : DONE 🏁"
}
_PRINTUSAGE_
