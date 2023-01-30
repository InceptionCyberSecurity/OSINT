#!/bin/bash
# use only for Hyperion v3.1 on Ubuntu 21.04
# Script for Hyperion v3.x that tests ftp servers
# Usage ./ftp.sh 8.8.8.8 port mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# Second Argument $2: $uport port number
# third argumnet $3 mydir
# User Input from  command line arguments
userIP="$1" # target URL eg. google.com
uport="$2" # user port
udir="$3" # directory for reports
uname="$4" # unsername for social media
umail="$5" # email to search for
# finalrecon
python3 finalrecon.py --full $userIP

# dnsenum
dnsenum $userIP

# theHarvester
theHarvester -d $userIP -l 200 -b bing
 
# twint
twint -u $uname --followers --user-full

# Sherlock see https://github.com/sherlock-project/sherlock#installation
python3 sherlock $uname
# python3 sherlock user1 user2 user3

# Ashok see https://www.geeksforgeeks.org/ashok-osint-recon-tool-in-kali-linux/
python3 Ashok.py --headers https://$userIP

# MOSINT see https://www.geeksforgeeks.org/mosint-osint-tool-for-emails-in-kali-linux/
python3 mosint.py -e $umail

# all dns
sudo nmap -p - --script dns* $userIP -oX dns.xml
xslproc dns.xml -o dns.html

# all Discovery
sudo nmap -p - --script discovery $userIP -oX disc.xml
xslproc disc.xml -o disc.html

# local storage ready for upload to client's container
cd /
cd root
mkdir $udir
cd $udir
mv /root/dns.html /root/$udir/dns.html
mv /root/disc.html /root/$udir/disc.html

echo " Your results are stored in directory $udir "
sleep 10
cd /
cd root
