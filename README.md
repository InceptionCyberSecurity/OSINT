# INTRO
A set of OSINT commands all in one script. Saves results to files for further processing as necessary. <br/>
Includes passive scanning using Nmap. Essential to run these through TL-OSINT in VirtualBox. <br/>
See https://www.tracelabs.org/initiatives/osint-vm and how to install TL-OSINT. <br/>
You can also use these scripts in Kali Linux. Any other Linux version will not have the necessary dependencies. <br/>
Written by Nathan Jones nathan.jones@arcadeusops.com. <br/>

# INSTALLATION
git clone https://github.com/ArcadeusOPS/OSINT.git <br/>
cd OSINT <br/>
sudo chmod 755 *.sh <br/>
sudo ./install.sh <br/>
rm install.sh <br/>
<br/>
NOTE: Make sure that torrc is configured to SOCKS_PORT localhost:9050 <br/>

# Scripts
install.sh installs a few extras. up.sh updates the base, installed TL-OSINT OS. <br/>
osint.sh runs the scripts and saves output to local storage. Follow the instruction in the osint.sh file comments. <br/>

# SSH
Use port 1965 or higher if you want to be extra security minded. Use UFW firewall. <br/>

# SECURITY
You can install Lynis, ufw, apparmor, artillery, fail2ban - for added security. <br/>
Run Lynis and follow the recommendations. <br/>

# USAGE
./osint.sh and follow the prompts. Target address e.g. google.com for 8.8.8.8. <br/>
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
