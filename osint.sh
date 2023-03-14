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
echo " osint.sh will start automatically ........ "
mkdir $udir
sleep 6
# finalrecon
finalrecon --full https://$userIP > finalrec.txt
sed -i -e '1iFinalRecon files\' finalrec.txt
sed -i -e '2i***************************\' finalrec.txt
# dnsenum
dnsenum $userIP -o dnsrec.xml
xsltproc dnsrec.xml -o dnsrec.html
# theHarvester
theHarvester -d $userIP -l 200 -b All -f harvest.xml
xsltproc harvest.xml -o harvest.html
# Ashok see https://www.geeksforgeeks.org/ashok-osint-recon-tool-in-kali-linux/
cd Ashok
python3 Ashok.py --headers --subdomain --dorknumber 10 --cms https://$userIP > ashok.txt
sed -i -e '1iAshok files\' ashok.txt
sed -i -e '2i***************************\' ashok.txt
mv ashoktxt /$udir
cd ..
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
sed -i -e '1iTrape files\' trape.txt
sed -i -e '2i***************************\' trape.txt
# photon
python photon.py -u "$userIP" --clone > photon.txt
sed -i -e '1iPhoton files\' photon.txt
sed -i -e '2i***************************\' photon.txt
# torbot
sudo service tor start # make sure that torrc is configured to SOCKS_PORT localhost:9050
poetry run python run.py -u https://$userIP --depth 2 -v > torbot.txt # example of running command with poetry
sed -i -e '1iTorbot Dark Web files\' torbot.txt
sed -i -e '2i***************************\' torbot.txt
# poetry run python run.py -h # for help
# nmapAutomator
./nmapAutomator.sh --host $userIP --type All > nmA.txt
# local storage ready for upload to client's container
cat *.txt > allrep.txt
sed -i -e '1iAll OSINT .txt files\' allrep.txt
sed -i -e '2i******************************************************\' allrep.txt
mv *.txt /$udir
mv *.html /$udir
mv *.xml /$udir
#
echo " "
echo " Your results are stored in directory $udir and /root/RFTW ."
cd /
cd root
