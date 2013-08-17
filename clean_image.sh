#!/bin/bash
# Prepares an OLA Raspberry Pi image for relase
# (C) 2013 Simon Newton

apt-get update && apt-get upgrade
apt-get autoclean
apt-get clean

rm /etc/hostip
rm /root/.bash_history
rm /home/pi/.bash_history

# Remove the OLA settings
rm -Rf /home/pi/.ola

# Zero out the file system
cat /dev/zero > /tmp/fill; rm /tmp/fill

# Don't leave config in resolv.conf - see bug #233
# Instead we use Google DNS.
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Warn about over-clocking
if [ $(grep arm_freq /boot/config.txt  | cut -d= -f2) -ne "700" ]; then
  echo "-------------------------------";
  echo "Warning - overclocking enabled!";
fi
