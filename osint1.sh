#!/usr/bin/env bash
# Nathan Jones nwj@inception.bz
# INSTALL FIRST https://github.com/twintproject/twint https://github.com/sherlock-project/sherlock https://github.com/alpkeskin/mosint
pip3 install twint
# clone the repo
git clone https://github.com/sherlock-project/sherlock.git
# change the working directory to sherlock
cd sherlock
# install the requirements
python3 -m pip install -r requirements.txt
#
go install -v github.com/alpkeskin/mosint/v3/cmd/mosint@latest
#
sudo apt-get update
sudo apt-get install python3 python3-pip
pip3 install social-analyzer
#
n=$1 # Username to search
s=$2 # user email to search

# NOTE!!!!! Don't forget to insert your API Keys in Sherlock, MOSINT and Twint

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

cat *.txt > allrep.txt
sed -i -e '1iAll OSINT .txt files\' allrep.txt
sed -i -e '2i******************************************************\' allrep.txt

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} OSINT1.zip allrep.txt

# Email Report and Password
echo " OSINT Report OSINT1.zi" | mail -s "MOSINT SHERLOCK TWINT Report for "$1" " -A OSINT1.zi $2
echo " Your password for "$1" OSINT1.zi is "${pass}" " | mail -s "Your OSINT1.zi Info" $2
cd ..
