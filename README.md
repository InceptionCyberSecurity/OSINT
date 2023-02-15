# INTRO
A set up OSINT commands all in one script. Saves to files for further processing as necessary.
Best to run these through TL-OSINT, BlackArch or Kali Linux in VirtualBox. See https://www.tracelabs.org/initiatives/osint-vm and how to install TL-OSINT.

# INSTALLATION
OSINT tools are:-
trape trackerjacker social-analyzer photon discover torbot nmapAutomator Ashok Sn1per reconFTW Spiderfoot
Dependencies, System Tools and Libraries installed are listed in install.sh but TL-OSINT and Kali has most of them.

# Scripts
install.sh installs a few extra apps not found in TL-OSINT or Kali.
up.sh updates the base, installed OS.
osint.sh runs the scripts and saves output to local storage

# SSH
use port 1965 or higher if you want to be extra security minded.

# SECURITY
You can install UFW, apparmor, artillery, fail2ban - just uncomment the appropriate lines in install.sh. Run Lynis and follow instructions.

# USAGE
./osint.sh 8.8.8.8 port mydir uname umail - as single command line argument but can use website instead of IP address e.g. google.com for 8.8.8.8.
See install.sh for notes.

# TO DO
Collate all output to XML or HTML file and email to designated user.
