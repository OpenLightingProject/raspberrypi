INSTALL=install
prefix=
user=pi
group=pi

install:
	for f in `find home -type f`; do \
	  dir=$$(dirname $$f); \
	  $(INSTALL) -d $(prefix)/$$dir; \
	  $(INSTALL) -c -o $(user) -g $(group) -m 744 $$f $(prefix)/$$dir; \
	done
	install -d $(prefix)/etc
	install -m 744 etc/rc.local $(prefix)/etc

git-install: install
	for f in `find etc/modprobe.d etc/udev -type f`; do \
	  dir=$$(dirname $$f); \
	  $(INSTALL) -d $(prefix)/$$dir; \
	  $(INSTALL) -c -m 744 $$f $(prefix)/$$dir; \
	done;

.PHONY: install git-install
