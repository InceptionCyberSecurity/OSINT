#!/bin/bash
# OSINT and Scanning Hyperion v3.1 2023 by ducatinat nathan.jones@arcadeusops.com; Ubuntu 21.04
# big.txt in /user/share/wordlists/dirb/ https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/big.txt
# Docker https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
cd /
cd root
echo " Welcome to the Hyperion v3.1 Installation Script for OSINT/general scanning. Base OS is Kali Linux. "
echo " This installation script will setup all requirements. LOOK AT OPTIONS IN COMMENTS!! Installation will automatically start ........ "
echo " "
sleep 8
# INSTALL BASE REQUITREMENTS
sudo apt update
sudo apt upgrade -y && sudo apt dist-upgrade -y
sudo apt install git dnsrecon curl ruby perl php docker apparmor chkrootkit tor nmap ffuf -y
sudo apt install ufw fail2ban net-tools dnsutils openssl python3 python2.7 xsltproc libxml2-utils python3-pip python2.7-dev python-docutils -y
sudo apt install inetutils-traceroute geoip-bin geoip-database python3-dnspython python3-tld python3-geoip python3-whois python3-requests -y
sudo apt install python3-ssdeep software-properties-common monit debsums auditd apt-transport-https sysstat unattended-upgrades apt-show-versions traceroute setuptools -y
sudo add-apt-repository universe
# openvpn
# wget https://git.io/vpn -O openvpn-install.sh
# sudo chmod +x openvpn-install.sh
# sudo bash openvpn-install.sh
# install sslyze
# git clone git://github.com/nabla-c0d3/sslyze.git
# cd sslyze
# pip install .
# cd ..
# sudo auditd -s enable
# auditctl -D
# auditctl -a exit,always -F path=/etc/passwd -F perm=wa
# auditctl -R /etc/audit/audit.rules
# seclists for password cracking
git clone https://github.com/danielmiessler/SecLists.git
# lynis
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 013baa07180c50a7101097ef9de922f1c2fde6c4
echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" | sudo tee /etc/apt/sources.list.d/cisofy-lynis.list
sudo apt update
sudo apt install lynis
# tecmint monitor
wget https://tecmint.com/wp-content/scripts/tecmint_monitor.sh
chmod 755 tecmint_monitor.sh
./tecmint_monitor.sh -i
# spiderfoot OSINT
# NOTE that spiderfoot needs use of https://localhost:5001. See https://github.com/smicallef/spiderfoot
# git clone https://github.com/smicallef/spiderfoot.git
# cd spiderfoot
# pip3 install -r requirements.txt
# cd ..
# reconFTW https://github.com/six2dez/reconftw#a-in-your-pcvpsvm ./reconftw.sh -d target.com -a -o /root/RFTW
git clone https://github.com/six2dez/reconftw
cd reconftw/
./install.sh
cd ..
# sn1per https://github.com/1N3/Sn1per
git clone https://github.com/1N3/Sn1per
cd Sn1per
sudo ./install.sh
cd ..
# Ashok https://github.com/powerexploit/Ashok
git clone https://github.com/ankitdobhal/Ashok
cd Ashok
python3.7 -m pip3 install -r requirements.txt
clear
cd ..
# trape
git clone https://github.com/jofpin/trape.git
cd trape
pip3 install -r requirements.txt
python3 trape.py -h
cd ..
# trackerjacker
pip3 install trackerjacker
# social-analyzer
sudo apt-get install python3 python3-pip
pip3 install social-analyzer
# photon
git clone https://github.com/s0md3v/Photon.git
cd Photon
pip3 install -r requirements.txt
cd ..
# discover
git clone https://github.com/leebaird/discover /opt/discover/
# torbot
sudo service tor start
cd gotor && go run cmd/main/main.go -server
poetry install # to install dependencies
# nmapAutomator
git clone https://github.com/21y4d/nmapAutomator.git
sudo ln -s $(pwd)/nmapAutomator/nmapAutomator.sh /usr/local/bin/
#
# INSTALL SECURITY REQUIREMENTS to harden up base server
# Lynis already installed lynis audit system
# Lynis report file /var/log/lynis-report.log. Look at Lynis audit report after installation. Do what Lynis suggests!!
# sudo aa-complain /etc/apparmor.d/* # complain module
# sudo aa-enforce /etc/apparmor.d/* # enforce mode
# sudo aa-genprof slapd #generate new profile for app called slap
# systemctl enable apparmor
# systemctl restart apparmor
# sudo apparmor_status > apparmor.txt # look at this after install
# Apparmor logs to /var/log/syslog
# dmseg | grep -i 'apparmor.*denied' /var/log/syslog > apparmor_denied # use this to truncate syslog
# RAT detection
echo " Checking for RAT Intrusions........ "
sleep 2
chkrootkit > rootkit.txt
# Artillery honeypot
# blacklist /var/artillery/banlist.txt
# edit /var/artillery/config to turn on mail delivery
# cd /
# cd root
# sudo git clone https://github.com/BinaryDefense/artillery/ artillery/
# cd artillery
# python3 setup.py # answer Yes to all three questions
# configure Artillery as below
# nano /var/artillery/config
# change MONITOR_FOLDERS=”/var/www”,”/etc”,"/etc/passwd","/etc/shadow","/root"  for folders to be monitored
# change EXCLUDE="" for folders not monitored
# WHITELIST_IP=127.0.0.1,localhost,xxx.xxx.xxx.xxx <-Replace the x's with VPN IP address.
# PORTS="135,445,22,21,25,53,110" for ports to be honeypotted
# AUTO_UPDATE=ON
# ANTI_DOS_PORTS=22,80,443,1194
# ANTI_DOS=ON
# service artillery start
# sudo systemctl enable artillery
# to reset baned IP    cd /var/artilley  and run  ./reset-bans.py xxx.xxx.xxx.xxx
# cd ..
# ClamAV malware scanner https://ourcodeworld.com/articles/read/885/how-to-install-clamav-and-scan-for-viruses-with-the-command-line-cli-in-ubuntu-16-04
# sudo systemctl stop clamav-freshclam
# sudo freshclam
# sudo systemctl start clamav-freshclam
# sudo clamscan -i --detect-pua=yes -r / # manual scan
# configure then stop apache2 select Local only for mail setup
# sudo systemctl start apache2
# sudo apt install libapache2-mod-evasive libapache2-mod-security2 -y
# sudo nano /etc/apache2/mods-enabled/evasive.conf the follow https://phoenixnap.com/kb/apache-mod-evasive
# /etc/apache2/mods-enabled/security2.conf follow https://www.linuxbabe.com/security/modsecurity-apache-debian-ubuntu
# sudo a2enmod security2
# sudo systemctl disable apache2 && sudo systemctl stop apache2
# sudo systemctl stop postfix
# prevent postfix from booting https://duckduckgo.com/?q=prevent+postfix+from+starting+at+boot&t=newext&atb=v268-1&ia=web
# sudo update-rc.d postfix disable # to restart at boot sudo update-rc.d postfix enable
# logs in /var/logs/mod_evasive
# continue AppArmor install and server hardening
# nano /sys/module/apparmor/parameters/enabled and edit as below
# set to complain mode see https://ubuntu.com/server/docs/security-apparmor sudo aa-complain /path/to/bin
# set to enforce mode sudo aa-enforce /path/to/bin sudo apparmor_status
# sudo aa-status > apparmor.txt # check apparmor is running
# install UFW and configure https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-20-04
# sudo ufw default deny incoming
# sudo ufw default allow outgoing
# sudo ufw allow https # for API from front end         sudo ufw allow 443 # for API from front end
# sudo ufw allow ssh
# sudo ufw allow 1965 # CHANGE TO UNUSUAL SSH PORT for added security
# sudo ufw allow 1194 # VPN only
# sudo ufw allow from xxx.xxx.xxx.xx USE FOR VPN ACCESS ONLY
# sudo ufw enable
# sudo systemctl enable ufw
# run sudo ufw status verbose to check ufw is running after install        sudo ufw reset
# fail2ban https://linuxize.com/post/install-configure-fail2ban-on-ubuntu-20-04/
# sudo cp /etc/fail2ban/jail.{conf,local}
# sudo nano /etc/fail2ban/jail.local and edit as required
# systemctl enable fail2ban
# system start fail2ban
# END OF BASE and Security Install
cd /
cd root
echo "Hyperion 3.1 system installation is complete. Updating all ... "
sleep 2
# update
sudo nmap --script-update
sudo nmap --script-updatedb
sudo apt update
sudo apt upgrade -y && sudo apt dist-upgrade -y
sudo apt autoclean -y && sudo apt autoremove -y
clear
echo " Server is now ready to reboot. Before using Hyperion v3.1 you need to do the following:-"
echo " 1. Run Lynis audit report after full installation (lynis audit system). Lynis report in /var/log/lynis-report.log. Do what Lynis suggests!"
echo " A Lynis Hardening Index of 70+ is respectable. See https://blog.ssdnodes.com/blog/tutorial-vps-security-audits-using-lynis/ "
# echo " 2. Look at apparmor.txt and /var/log/syslog to confirm Apparmor is in complain mode, and /var/logs/mod_evasive, and do evasive_mod and mod_security editing."
# echo " 3. Edit /var/artillery/config and change Folders Monitored/Ignored, Honeypot Ports, Whitelist and DOS Protection. "
# echo " 4. Run sudo ufw status verbose to check ufw is running after install. Edit /etc/default/sysstat to TRUE. "
# echo " 5. Test fail2ban according to https://www.howtogeek.com/675010/how-to-secure-your-linux-computer-with-fail2ban/"
echo " Happy hacking! "
read -p " Take note of the above then press enter to reboot."
sudo reboot
