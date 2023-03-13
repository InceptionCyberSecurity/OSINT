#!/usr/bin/env bash
# Nathan Jones nathan.jones@arcadeusops.com
# userIP= target URL eg. google.com or IP address. Preferable to use domain name
# udir= directory for reports and scan data
echo " This is osint.sh and is executes OSINT Scan and Passive Recon on a Target Domain. "
echo " You will need a Target Domain. You'll be asked where you want to store the Reports. "
echo " "
read -p "Enter target domain name or IP address e.g. mysite.com : " userIP
echo "Your target is : $userIP"
echo " "
read -p "Enter the local directory for reports to be saved to e.g MyStuff : " udir
echo "Your local directory is : $udir"
echo " "
echo " These OSINT scripts may take along time to run so grab a coffee! "
echo " Don't forget to insert API Keys e.g. MOSINT and theHarvester. "
echo " osint.sh will start automatically ........ "
sleep 6
# finalrecon
finalrecon --full https://$userIP -o finalrec.txt
# dnsenum
dnsenum $userIP -o dnsrec.xml
xsltproc dnsrec.xml -o dnsrec.html
# theHarvester
theHarvester -d $userIP -l 200 -b All -f harvest.xml
xsltproc harvest.xml -o harvest.html
# Ashok see https://www.geeksforgeeks.org/ashok-osint-recon-tool-in-kali-linux/
python3 Ashok.py --headers --subdomain --dorknumber 10 --cms https://$userIP > ashok.txt
# sn1per https://github.com/1N3/Sn1per
sniper -t $userIP # normal mode
sniper -t $userIP -o -re # OSINT and RECON
sniper -t $userIP -m stealth -o -re # Stealth OSINT and RECON
# reconFTW https://github.com/six2dez/reconftw#a-in-your-pcvpsvm
./reconftw.sh -d $userIP -a -o /root/RFTW
# all dns
sudo nmap -p - --script dns* $userIP -oX dns.xml
xsltproc dns.xml -o dns.html
# all Discovery
sudo nmap -p - --script discovery $userIP -oX disc.xml
xsltproc disc.xml -o disc.html
# trape chnage port 80 eg 443
python3 trape.py --url $userIP --port 80 > trape.txt
# photon
python photon.py -u "$userIP" --clone > photon.txt
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
mv /root/ashok.txt /root/$udir/ashok.txt
mv /root/trape.txt /root/$udir/trape.txt
mv /root/photon.txt /root/$udir/photon.txt
mv /root/nmA.txt /root/$udir/nmA.txt.txt
mv /root/torbot.txt /root/$udir/torbot.txt
echo " "
echo " Your results are stored in directory $udir and /root/RFTW ."
cd /
cd root
