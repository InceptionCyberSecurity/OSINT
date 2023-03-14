#!/usr/bin/env bash
# Nathan Jones nathan.jones@arcadeusops.com
# udir= directory for reports and scan data
# uname= username for social media searches eg "Knobby Knobs"
# umail= email to search for in social media 
echo " "
echo " This is osint1.sh for OSINT Scan and Passive Recon on a Username and Email address."
echo " Provide a Username and Email to search for. You'll be asked where you want to store the Reports. "
echo " NOTE:  osint.sh uses a specified Domain Name; osint1.sh uses a specified Username/Email. "
echo " "
read -p "Enter username e.g. Bobby Bobson or bobbybobson: " uname
echo "Your target username is : $uname"
echo " "
read -p "Enter the email to search for e.g someone@someserver.com: " umail
echo "Your target email is : $umail"
echo " "
read -p "Enter the local directory for reports to be saved to e.g MyStuff : " udir
echo "Your local directory is : $udir"
echo " "
echo " These OSINT scripts may take a long time to run so grab a coffee! "
echo " NOTE!!!!! Don't forget to insert API Keys e.g. MOSINT and theHarvester. "
echo " osint.sh will start automatically ........ "
mkdir $udir
sleep 6
# twint
twint -u $uname --followers --user-full --email --phone -o twint.txt
sed -i -e '1iTwint files\' twint.txt
sed -i -e '2i***************************\' twint.txt
# Sherlock see https://github.com/sherlock-project/sherlock#installation
sherlock --verbose $uname $umail --output sherly.txt --xlsx sherly.xlsx
sed -i -e '1iSherlock files\' sherly.txt
sed -i -e '2i***************************\' allrep.txt
# python3 sherlock user1 user2 user3
# Accounts found will be stored in an individual text file with the corresponding username (e.g user123.txt).
# MOSINT see https://www.geeksforgeeks.org/mosint-osint-tool-for-emails-in-kali-linux/
# MOSINT API keys
# mosint set hunter <18a27fba1f51ed59e52d49fd483c6dbcad020bda>
# mosint set emailrep <emailrep.io API key>
# mosint set intelx <af057190-f051-4041-a619-52cebcd55f43>
# mosint set psbdmp <06854e5ed04880d9739c87beee73bbd2>
# mosint set breachdirectory <58fff0d5d5msh8b2308b757609ebp1dd419jsn2dbc042b4e27>
#
mosint $umail > mosint.txt
sed -i -e '1iMOSINT .txt files\' mosint.txt
sed -i -e '2i***************************\' mosint.txt
# socan
python3 -m social-analyzer --username "$uname" > socan.txt
sed -i -e '1iSocial analyser .txt files\' socan.txt
sed -i -e '2i***************************\' socan.txt
# local storage ready for upload to client's container
cat *.txt > allrep.txt
sed -i -e '1iAll OSINT .txt files\' allrep.txt
sed -i -e '2i******************************************************\' allrep.txt
mv *.txt /$udir
mv *.xlsx /$udir
#
echo " "
echo " Your results are stored in directory $udir ."
cd /
cd root
