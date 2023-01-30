#!/bin/bash
# use only for Hyperion v3.1 on Ubuntu 21.04 
sudo nmap --script-update
sudo apt update
sudo apt upgrade -y && sudo apt dist-upgrade -y
sudo apt autoclean -y && sudo apt autoremove -y
sudo apt clean
# clean up diskspace
sudo find /tmp -type f -atime +10 -delete
sudo journalctl --rotate
sudo journalctl --vacuum-time=1days
sudo journalctl --vacuum-size=5M
sudo systemctl stop apache2
sudo systemctl stop postfix
echo " "
echo " Checking for rootkits and intrusions. Read /var/log/syslog, sarq.txt, saru.txt, rootkit.txt and apparmor.txt "
echo " and investigate any unusual files/activity. "
echo " "
# rootkit, auditd, sysstat and apparmor check
chkrootkit > rootkit.txt
apparmor_status > apparmor.txt
sar -q > sarq.txt
sar -u > saru.txt
ausearch -f /etc/passwd > audit.txt
echo " "
echo " Running Tecmint's Server Info Script. "
echo " "
sleep 5
monitor
