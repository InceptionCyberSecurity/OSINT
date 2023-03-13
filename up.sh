#!/bin/bash
# use only for Hyperion v3.1 on Kali
sudo apt update
sudo apt upgrade -y && sudo apt dist-upgrade -y
sudo apt autoclean -y && sudo apt autoremove -y
sudo apt clean
# clean up diskspace
sudo find /tmp -type f -atime +10 -delete
#
echo " Update successful."
