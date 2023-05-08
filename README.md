# INTRO
A set of BASH commands in two scripts for OSINT and Passive Recon. Saves results to files for further processing as necessary. <br/>
Includes passive scanning using Nmap. Essential to run these through Kali Linux in VirtualBox. Written by Nathan Jones nathan.jones@arcadeusops.com. <br/>

# INSTALLATION
git clone https://github.com/ArcadeusOPS/OSINT.git <br/>
cd OSINT <br/>
sudo chmod 755 *.sh <br/>
sudo ./install.sh <br/>
rm install.sh <br/>
<br/>
NOTE: Make sure that torrc is configured to SOCKS_PORT localhost:9050. Use your own APIs for Shodan, theHarvester, MOSINT, Sherlock and Twint. <br/>

# Scripts
install.sh installs a few extras. up.sh updates the base, installed Kali OS. <br/>
osint.sh and osint1.sh run the individual commands and saves output to local storage. Follow the instruction in the osint.sh and osint1.sh file comments. <br/>

# SSH
Use port 1965 or higher if you want to be extra security minded. Use UFW firewall. <br/>

# SECURITY
You can install Lynis, ufw, apparmor, artillery, fail2ban - for added security. <br/>
Run Lynis and follow the recommendations. <br/>

# USAGE
./osint.sh is to search a given Domain, follow the prompts. <br/>
./osint1.sh is to search a given Username/Email, follow the prompts. <br/>
See install.sh for notes. <br/>

## Ethical Notice
The original code is written by ArcadeusOPS, who are not responsible for misuse of this data gathering tool.  <br/>
Do not use these scripts to navigate websites/devices that take part in any activity that is identified as illegal under the laws and regulations of your government. STAY LEGAL !! <br/>

## License
MIT License
Copyright (c) ArcadeusOPS

# TO DO
Collate all output to a single XML or HTML file and email to designated user.

# Bugs
Send issues to info@arcadeusops.com stating nature of issue. A screenshot will help too. Thanks.

# CPD
Part of EC-Council ECE/CPD Credits
