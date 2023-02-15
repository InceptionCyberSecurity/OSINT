#!/bin/bash
# OSINT and Scanning Hyperion v3.1 2023 by ducatinat nathan.jones@arcadeusops.com; TL-OSINT
# big.txt in /user/share/wordlists/dirb/ https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/big.txt
cd /
cd root
echo " Welcome to the Hyperion v3.1 Installation Script for OSINT/general scanning. Base OS is TL-OSINT. "
echo " This installation script will setup all requirements. Installation will automatically start ........ "
echo " "
sleep 8
# INSTALL BASE REQUITREMENTS
sudo apt update
sudo apt upgrade -y && sudo apt dist-upgrade -y
sudo apt install dnsrecon chkrootkit tor ffuf -y
sudo apt install net-tools dnsutils openssl python3 python2.7 xsltproc libxml2-utils python3-pip python2.7-dev python-docutils -y
sudo apt install inetutils-traceroute geoip-bin geoip-database python3-dnspython python3-tld python3-geoip python3-whois python3-requests -y
sudo apt install python3-ssdeep software-properties-common monit debsums apt-transport-https unattended-upgrades apt-show-versions traceroute setuptools -y
sudo add-apt-repository universe
# seclists for password cracking
git clone https://github.com/danielmiessler/SecLists.git
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
clear
echo " Checking for RAT Intrusions........ "
chkrootkit > rootkit.txt
#
cd /
cd root
echo " Hyperion 3.1 system installation is complete. Updating all ... "
echo " See README and osint.sh for usage. "
sleep 2
# update
sudo nmap --script-update
sudo apt update
sudo apt upgrade -y && sudo apt dist-upgrade -y
sudo apt autoclean -y && sudo apt autoremove -y
clear
echo " Server is will now automatically reboot. "
sleep 3
sudo reboot
