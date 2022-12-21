sudo find /bin/ -user root -perm -4000 -exec ls -ldb {} \; https://www.thegeekdiary.com/understanding-basic-file-permissions-and-ownership-in-linux/

watch -n 1 "sudo netstat -ntlpa | grep -i established | cut -d ":" -f 2 | awk '{print $2}' | grep -iv "internet" | sort -u";

sudo dd if=/dev/sda conv=sync,noerror bs=64k | gzip -c > /tmp/sda.img.gz #takes backup of /dev/sda in a gzip file (dont take backup from the whole device in the same operating system) https://www.thegeekdiary.com/how-to-backup-linux-os-using-dd-command/#:~:text=2.,everything%20using%20synchronized%20I%2FO.

gunzip -c /tmp/sda.img.gz | sudo dd of=/dev/sda

fsck (repair unmount device first)

mkswap (make swap)

resize2fs (resize hard disks) https://askubuntu.com/questions/709716/resize-vm-partition-without-erasing-data

### process managermentc
ps -auxf (pid tty stat time command)
ps -AFL (pid ppid lwp c nlwp sz rss psr Stime tty)
ps -AFL --forest (tree hierarchy)
ps -u neko (gets processes of user neko)
ps -p <processid> (gets information about process based on process id)
ps -Fp <processid> (more info about prcoess)
ps -p <processid> -L -o pid,tid,pcpu,pmem,state,command (all the threads of a process)
ps aux | sort -nr -k 3 | head -n 5 (show the top 5 processes that use the most cpu)
ps -eo size,pid,user,pcpu,comm --sort cpu | head -n 5
pgrep termite (gets the pid of termite)
htop -p <processid>

/proc is the folder that every process is a folder. also there is a file for modules and other cool stuff

stat and file are programs to examine files and folders

### user/group management
in /etc/shadow
neko:$6$Fl7DFOSWcK1r6i4S$z3WkNoQo1sadwdaddawd/JOHggKzIAoodawdawdsadzGve0GhmjQAFX/:18494:0:99999:7:::
user:$hashtype$hash salt$hash:time since 1970 timeframe to change password:a boolean that enables/disable previous time limit:password expiery(99999 = never):number of days before password expiary that user gets a warning:account:expiary:date:

sudo useradd -m (homepage) -f <days>(days till expiary) -e <date> (expiary date) <username>
sudo adduser (has a wizard)
sudo passwd (changes password)
sudo userdel -r <username> (deletes a user)
sudo groupadd <groupname> (makes a new group)
sudo usermod -g <group> <user> (adds user to a group)
sudo usermod -G <group1> <group2> <user> (adds user to multiple groups)
sudo usermod -l <username> <user> (changes username)

sudo chage -M 90 -W 7 -I 30 <user> (set a user to have a password expiary of 90 days (-M), gives warning 7 days the expiary (-W), and locks his account after 30 days if inactivity -I)
sudo chage -d 0 <user> (set the number of days to change password to 0. so the user has to change password)
sudo chage -l <user> (lists the password policy of a user)
sudo chage -E0 <user> (expire a user)
sudo chage -E-1 <user> (re-enable the user)
sudo usermod -L <user> (locks user. authentication failure only)
sudo usermod -U <user> (unlock user)

# access level:
when you want to add aditional access level to a file or folder, say you want a user to temporary access a file from another users directory you use setfacl to that file.

setfacl -m u:neko:rwx (modifies neko's access with -m)

# sudoers
sudoers file in /etc/sudoers allows you to modify the capability of sudo for each user. 
you can add the user "neko" to the sudoers file via adding this to the file:
  76   │ ##
  77   │ ## User privilege specification
  78   │ ##
  79   │ root ALL=(ALL) ALL
  80   │ neko ALL=(ALL) NOPASSWD:ALL
     username allhosts=(all users) nopasswd:allbinaries 

# show who's logged in
use w, who, who -a to see who is logged in
last -F | grep -i "still"

# list all activity of users
sudo lastb
sudo lastb -s -10min -t -1min (shows last activity of users starting from last 10 minutes up to last minute)
sudo utmpdump /var/log/btmp
sudo utmpdump /var/log/wtmp
/var/log/secure is a log file that logs auhtentication

# iprout, ip
ip a (shows interfaces)
ip -4 a show <interface> (gives info about a specific interface like eth0)
ip link ls up (shows active interfaces)
ip -s link (shows statistics about packets)
ip a add 10.0.0.10/24 dev  <interface> (adds ip to that interface)
ip a del 10.0.0.10/24 dev  <interface> (deletes ip from that interface)
ip link set <interface> down/up (activate/deactivates an interface)
ip link set mtu <size-of-packet> dev <interface> (modifies mtu in interface which is the size of largest packet that can be sent over the internet)
ip link set txqueuelen <size-of-buffer> dev <interface> (modifies qlen which is the buffer size)