PASSIVEFTP	= --passive-ftp
SUDO		= sudo
PTXUSER		= $(shell echo $$USER)
GNU_HOST	= $(shell uname -m)-linux
HOSTCC		= gcc
CROSSSTRIP	= $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-strip

#
# some convenience functions
#

# FIXME: missing



# vim: syntax=make
