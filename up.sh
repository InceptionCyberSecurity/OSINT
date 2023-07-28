#!/bin/bash
# use only on Kali Linux
sudo apt update
sudo apt upgrade -y && sudo apt dist-upgrade -y
sudo apt autoclean -y && sudo apt autoremove -y
sudo apt clean
# clean up diskspace
sudo find /tmp -type f -atime +10 -delete
echo " "
echo " Update successful. Run install.sh if OSINT not already active. "
echo " "
