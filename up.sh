#!/bin/bash
# use only for Hyperion v3.1 on TL-OSINT
sudo apt update
sudo apt upgrade -y && sudo apt dist-upgrade -y
sudo apt autoclean -y && sudo apt autoremove -y
sudo apt clean
# clean up diskspace
sudo find /tmp -type f -atime +10 -delete
echo " "
echo " Checking for rootkits and intrusions. Read /var/log/syslog and rootkit.txt and investigate any unusual files/activity. "
echo " "
# rootkit check
chkrootkit > rootkit.txt
#
echo " Update successful. "
