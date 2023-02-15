# INTRO
A set of OSINT commands all in one script. Saves results to files for further processing as necessary.
Essential to run these through TL-OSINT, BlackArch or Kali Linux in VirtualBox. See https://www.tracelabs.org/initiatives/osint-vm and how to install TL-OSINT.

# INSTALLATION
sudo chmod 777 *.sh
sudo ./install.sh
rm install.sh

There are comments within install.sh that will allow installation of many options. Uncomment as you feel necessary.

# Scripts
install.sh installs a few extras.
up.sh updates the base, installed OS.
osint.sh runs the scripts and saves output to local storage

# SSH
Use port 1965 or higher if you want to be extra security minded.

# SECURITY
You can install UFW, apparmor, artillery, fail2ban - just uncomment the appropriate lines in install.sh.
Run Lynis and follow instructions.

# USAGE
./osint.sh 8.8.8.8 port mydir uname umail - as single command line argument but can use website instead of IP address e.g. google.com for 8.8.8.8.
See install.sh for notes.

# TO DO
Collate all output to a single XML or HTML file and email to designated user.
