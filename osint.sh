#!/usr/bin/env bash
# Nathan Jones nwj@inception.bz
# INSTALL FIRST https://github.com/thewhiteh4t/FinalRecon https://github.com/powerexploit/Ashok https://github.com/laramies/theHarvester/wiki/Installation
git clone https://github.com/thewhiteh4t/FinalRecon.git
cd FinalRecon
pip3 install -r requirements.txt
#
git clone https://github.com/laramies/theHarvester
cd theHarvester
mkdir ~/.theHarvester
cp api-keys.yaml ~/.theHarvester
docker build -t theharvester .
cd ..
#
~> git clone https://github.com/ankitdobhal/Ashok
~> cd Ashok
~> python3.7 -m pip3 install -r requirements.txt
cd ..
r=$1
k=$2

# NOTE!!!! Don't forget to insert your API Keys in theHarvester."

# finalrecon
docker pull thewhiteh4t/finalrecon
docker run -it --entrypoint /bin/sh thewhiteh4t/finalrecon --full https://$1 > finalrec.txt
sed -i -e '1iFinalRecon files\' finalrec.txt
sed -i -e '2i***************************\' finalrec.txt
# dnsenum
dnsenum $1 -o dnsrec.xml
xsltproc dnsrec.xml -o dnsrec.html
# theHarvester
docker run --rm -it --mount type=bind,source="$HOME/.theHarvester/api-keys.yaml",target="/app/api-keys.yaml" --entrypoint "/root/.local/bin/theHarvester" theharvester -d $1 -l 200 -b All -f harvest.xml
xsltproc harvest.xml -o harvest.html
# Ashok see https://www.geeksforgeeks.org/ashok-osint-recon-tool-in-kali-linux/
docker pull powerexploit/ashok-v1.2
docker container run -it powerexploit/ashok-v1.2 --headers --subdomain --dorknumber 10 --cms https://$1 > ashok.txt
# cd Ashok
# python3 Ashok.py --headers --subdomain --dorknumber 10 --cms https://$1 > ashok.txt
sed -i -e '1iAshok files\' ashok.txt
sed -i -e '2i***************************\' ashok.txt
cd ..
# sn1per https://github.com/1N3/Sn1per
sniper -t $1 # normal mode
sniper -t $1 -o -re # OSINT and RECON
sniper -t $1P -m stealth -o -re # Stealth OSINT and RECON
# reconFTW https://github.com/six2dez/reconftw#a-in-your-pcvpsvm
./reconftw.sh -d $1 -a -o /root/RFTW
# all dns
sudo nmap -p - --script dns* $1 -oX dns.xml
xsltproc dns.xml -o dns.html
# all Discovery
sudo nmap -p - --script discovery $1 -oX disc.xml
xsltproc disc.xml -o disc.html
# trape chnage port 80 eg 443
python3 trape.py --url $1 --port 80 > trape.txt
sed -i -e '1iTrape files\' trape.txt
sed -i -e '2i***************************\' trape.txt
# photon
python photon.py -u "$1" --clone > photon.txt
sed -i -e '1iPhoton files\' photon.txt
sed -i -e '2i***************************\' photon.txt
# torbot
sudo service tor start # make sure that torrc is configured to SOCKS_PORT localhost:9050
poetry run python run.py -u https://$1 --depth 2 -v > torbot.txt # example of running command with poetry
sed -i -e '1iTorbot Dark Web files\' torbot.txt
sed -i -e '2i***************************\' torbot.txt
# poetry run python run.py -h # for help
# nmapAutomator
./nmapAutomator.sh --host $1 --type All > nmA.txt
# local storage ready for upload to client's container
cat *.txt > allrep.txt
sed -i -e '1iAll OSINT .txt files\' allrep.txt
sed -i -e '2i******************************************************\' allrep.txt

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} OSINT.zip allrep.txt dnsrec.html harvest.html dns.html disc.html

# Email Report and Password
echo " OSINT Report CMS.zip" | mail -s "General CMS Malware Report for "$1" " -A OSINT.zip $2
echo " Your password for "$1" OSINT.zip is "${pass}" " | mail -s "Your OSINT.zip Info" $2
