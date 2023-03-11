#!/bin/bash
# use only on TL-OSINT
# Nathan Jones nathan.jones@arcadeusops.com
# Usage ./osint.sh 8.8.8.8 port mydir uname umail wlan- as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# User Input from  command line arguments
userIP="$1" # target URL eg. google.com or IP address. Preferable to use IP address and let the DNS sort out the primary IP ;-)
uport="$2" # user port if nmap needs it. Try 80 or 443
udir="$3" # directory for reports and scan data
uname="$4" # username for social media searches
umail="$5" # email to search for in social media
#
echo " These OSINT scripts may take along time to run so grab a coffee! "
echo " USAGE: ./osint.sh userIP uport udir uname umail wlan "
echo " Don't forget to insert API Keys e.g. MOSINT and theHarvester. "
echo " osint.sh will start automatically ........ "
sleep 6
# finalrecon
python3 finalrecon.py --full $userIP -o finalrec.txt
# dnsenum
dnsenum $userIP -o dnsrec.xml
xsltproc dnsrec.xml -o dnsrec.html
# theHarvester
theHarvester -d $userIP -l 200 -b bing -f harvest.xml
xsltproc harvest.xml -o harvest.html
# twint
twint -u $uname --followers --user-full --email --phone -o twint.txt
# Sherlock see https://github.com/sherlock-project/sherlock#installation
python3 sherlock --verbose $uname $umail --output sherly.txt --xlsx sherly.xlsx
# python3 sherlock user1 user2 user3
# Accounts found will be stored in an individual text file with the corresponding username (e.g user123.txt).
# Ashok see https://www.geeksforgeeks.org/ashok-osint-recon-tool-in-kali-linux/
python3 Ashok.py --headers --subdomain --dorknumber 10 --cms https://$userIP > ashok.txt
# MOSINT see https://www.geeksforgeeks.org/mosint-osint-tool-for-emails-in-kali-linux/
# MOSINT API keys
mosint set hunter <hunter.io API key>
mosint set emailrep <emailrep.io API key>
mosint set intelx <intelx.io API key>
mosint set psbdmp <psbdmp.ws API key>
mosint set breachdirectory <breachdirectory.org API key>
python3 mosint.py -e $umail > mosint.txt
# sn1per https://github.com/1N3/Sn1per
sniper -t $userIP # normal mode
sniper -t $userIP -o -re # OSINT and RECON
sniper -t $userIP -m stealth -o -re # Stealth OSINT and RECON
# reconFTW https://github.com/six2dez/reconftw#a-in-your-pcvpsvm
./reconftw.sh -d $userIP -a -o /root/RFTW
# all dns
sudo nmap -p - --script dns* $userIP -oX dns.xml
xslproc dns.xml -o dns.html
# all Discovery
sudo nmap -p - --script discovery $userIP -oX disc.xml
xslproc disc.xml -o disc.html
# trape
python3 trape.py --url $IP --port $uport > trape.txt
# socan
python3 -m social-analyzer --username "$uname" > socan.txt
# photon
python photon.py -u "$userIP" --clone > photon.txt
# discover
# cd /opt/discover/
# sudo ./discover.sh
# torbot
sudo service tor start # make sure that torrc is configured to SOCKS_PORT localhost:9050
poetry run python run.py -u https://$userIP --depth 2 -v > torbot.txt # example of running command with poetry
# poetry run python run.py -h # for help
# nmapAutomator
./nmapAutomator.sh --host $userIP --type All > nmA.txt
# local storage ready for upload to client's container
cd /
cd root
mkdir $udir
cd $udir
cat *.txt > allrep.txt
sed -i -e '1iAll OSINT .txt files\' allrep.txt
sed -i -e '2i***************************\' allrep.txt
#
mv /root/dns.html /root/$udir/dns.html
mv /root/disc.html /root/$udir/disc.html
mv /root/finalrec.txt /root/$udir/finalrec.txt
mv /root/dnsrec.html /root/$udir/dnsrec.html
mv /root/harvest.html /root/$udir/harvest.html
mv /root/twint.txt /root$udir/twint.txt
mv /root/sherly.txt /root/$udir/sherly.txt
mv /root/sherly.xlsx /root/$udir/sherly.xlsx
mv /root/ashok.txt /root/$udir/ashok.txt
mv /root/mosint.txt /root/$udir/mosint.txt
mv /root/trape.txt /root/$udir/trape.txt
mv /root/socan.txt /root/$udir/socan.txt
mv /root/photon.txt /root/$udir/photon.txt
mv /root/nmA.txt /root/$udir/nmA.txt.txt
mv /root/torbot.txt /root/$udir/torbot.txt
echo " "
echo " Your results are stored in directory $udir and /root/RFTW ."
echo " Use Lee Baird's discover for further analysis, cd /opt/discover; sudo ./discover.sh EASY!"
cd /
cd root
