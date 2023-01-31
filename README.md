Best to run these through TL-OSINT in VirtualBox but Arch/BlackArch Linux or Kali will be fine too.
See https://www.tracelabs.org/initiatives/osint-vm. Apps installed are OSINT Tools.
Dependencies, System Tools and Libraries installed are:-

curl ruby perl php docker apparmor chkrootkit clamav clamav-daemon openssl python3
python2.7 xsltproc inetutils-traceroute geoip-bin ufw fail2ban net-tools dnsutils
geoip-database monit debsums auditd sysstat unattended-upgrades traceroute

SSH
use port 1965 if you want to be extra sesurity minded.

USAGE
to run osint.sh e.g. ./osint.sh mytarget.com myDirectory
