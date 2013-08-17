INSTALL=install
prefix=
user=pi
group=pi

# Upgrade our system and remove any extra packages.
apt-upgrade:
	apt-get update && apt-get -y upgrade
	apt-get autoclean
	apt-get clean

install: apt-upgrade
	for f in `find home -type f`; do \
	  dir=$$(dirname $$f); \
	  $(INSTALL) -d $(prefix)/$$dir; \
	  $(INSTALL) -c -o $(user) -g $(group) -m 744 $$f $(prefix)/$$dir; \
	done
	install -d $(prefix)/etc
	install -m 744 etc/rc.local $(prefix)/etc

# Prepare a git repo based image
git-install: install
	for f in `find etc/modprobe.d etc/udev -type f`; do \
	  dir=$$(dirname $$f); \
	  $(INSTALL) -d $(prefix)/$$dir; \
	  $(INSTALL) -c -m 744 $$f $(prefix)/$$dir; \
	done;
	
	usermod -a -G dialout $(user)
	usermod -a -G plugdev $(user)
	
	# install the depdencies
	apt-get -y install libcppunit-dev libcppunit-1.12-1 uuid-dev pkg-config \
	libncurses5-dev libtool autoconf automake  g++ libmicrohttpd-dev \
	libmicrohttpd10 protobuf-compiler libprotobuf-lite7 python-protobuf \
	libprotobuf-dev zlib1g-dev bison flex make libftdi-dev libftdi1 \
	libusb-1.0-0-dev liblo-dev \

# Prepare a .deb based image.
deb-install: install
	apt-get -i install ola ola-rdm-tests

# Run this just before the image is copied. This does the final cleanup.
release: apt-upgrade
	rm -f /etc/hostip  # reset the hostip so we regenerate ssh keys on boot
	rm -f /root/.bash_history
	rm -f /home/pi/.bash_history
	
	rm -Rf /home/pi/.ola  # remove the OLA settings so we start fresh
	
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

.PHONY: apt-upgrade deb-install install git-install release
