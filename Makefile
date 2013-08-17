
INSTALL=install
prefix=

install:
	for f in `find etc -type f`; do \
	  dir=$$(dirname $$f); \
	  $(INSTALL) -d $(prefix)/$$dir; \
	  $(INSTALL) -c -m 744 $$f $(prefix)/$$dir; \
	done;
	for f in `find home -type f`; do \
	  dir=$$(dirname $$f); \
	  $(INSTALL) -d $(prefix)/$$dir; \
	  $(INSTALL) -c -m 744 $$f $(prefix)/$$dir; \
	done

.PHONY: install
