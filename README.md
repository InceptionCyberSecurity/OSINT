INTRO
Best to run these through TL-OSINT in VirtualBox but Arch/BlackArch Linux or Kali will be fine too.
See https://www.tracelabs.org/initiatives/osint-vm.
Apps installed are OSINT Tools.

INSTALLATION
OSINT tools are:-
trape trackerjacker social-analyzer photon discover torbot nmapAutomator Ashok Sn1per reconFTW Spiderfoot

Dependencies, System Tools and Libraries installed are:-
curl ruby perl php docker apparmor chkrootkit clamav clamav-daemon openssl python3
python2.7 xsltproc inetutils-traceroute geoip-bin ufw fail2ban net-tools dnsutils
geoip-database monit debsums auditd sysstat unattended-upgrades traceroute

SSH
use port 1965 or higher if you want to be extra security minded.

SECURITY
You can install UFW, apparmor, artillery, fail2ban - just uncomment the appropriate lines in install.sh

USAGE
./osint.sh 8.8.8.8 port mydir uname umail - as single command line argument but can use website instead of IP address e.g. google.com for 8.8.8.8.
