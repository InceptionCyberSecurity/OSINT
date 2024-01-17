#!/bin/bash
# big.txt https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/big.txt

# INSTALL BASE REQUITREMENTS
sudo apt update
sudo apt install golang gccgo-go golang-go tor finalrecon net-tools dnsutils python2.7 libxml2-utils python3-pip python2.7-dev python3-docutils -y
sudo apt install inetutils-traceroute geoip-bin geoip-database python3-dnspython python3-tld python3-geoip python3-whois python3-requests -y
sudo apt install git-all python3-ssdeep software-properties-common monit debsums apt-transport-https apt-show-versions -y
pip install poetry
# sn1per https://github.com/1N3/Sn1per
git clone https://github.com/1N3/Sn1per
cd Sn1per
sudo ./install.sh
cd ..
# Ashok https://github.com/powerexploit/Ashok
git clone https://github.com/ankitdobhal/Ashok
cd Ashok
python3 -m pip3 install -r requirements.txt
clear
cd ..
# trape
git clone https://github.com/jofpin/trape.git
cd trape
pip3 install -r requirements.txt
# python3 trape.py -h
cd ..
# social-analyzer
pip3 install social-analyzer
# torbot
sudo service tor start
https://github.com/DedSecInside/gotor.git
cd gotor && go run cmd/main/main.go -server
poetry install # to install dependencies
cd ..
# nmapAutomator
git clone https://github.com/21y4d/nmapAutomator.git
cd nmapAutomator
sudo ln -s $(pwd)/nmapAutomator/nmapAutomator.sh /usr/local/bin/
cd ..
# MOSINT https://github.com/alpkeskin/mosint
go install -v github.com/alpkeskin/mosint@latest
# MOSINT see https://www.geeksforgeeks.org/mosint-osint-tool-for-emails-in-kali-linux/
# MOSINT API keys RUN THESE MANUALLY !!!!
# mosint set hunter <18a27fba1f51ed59e52d49fd483c6dbcad020bda>
# mosint set emailrep <emailrep.io API key>
# mosint set intelx <af057190-f051-4041-a619-52cebcd55f43>
# mosint set psbdmp <06854e5ed04880d9739c87beee73bbd2>
# mosint set breachdirectory <58fff0d5d5msh8b2308b757609ebp1dd419jsn2dbc042b4e27>
# reconFTW https://github.com/six2dez/reconftw#a-in-your-pcvpsvm ./reconftw.sh -d target.com -a -o /root/RFTW
git clone https://github.com/six2dez/reconftw
cd reconftw
./install.sh
cd ..

# update and reboot
sudo nmap --script-update
sudo apt update
sudo apt autoclean -y && sudo apt autoremove -y
chmod 755 *.sh
