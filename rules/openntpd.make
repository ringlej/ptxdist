# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENNTPD) += openntpd

#
# Paths and names
#
OPENNTPD_VERSION	:= 3.7p1
OPENNTPD_MD5		:= 10ed8eefd760e5819efcf3277b118f47
OPENNTPD		:= openntpd-$(OPENNTPD_VERSION)
OPENNTPD_SUFFIX		:= tar.gz
OPENNTPD_URL		:= http://ftp.eu.openbsd.org/pub/OpenBSD/OpenNTPD/$(OPENNTPD).$(OPENNTPD_SUFFIX)
OPENNTPD_SOURCE		:= $(SRCDIR)/$(OPENNTPD).$(OPENNTPD_SUFFIX)
OPENNTPD_DIR		:= $(BUILDDIR)/$(OPENNTPD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENNTPD_PATH	:= PATH=$(CROSS_PATH)
OPENNTPD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
OPENNTPD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-privsep-user=ntp \
	--with-privsep-path=/var/run/ntp

ifdef PTXCONF_OPENNTPD_ARC4RANDOM
OPENNTPD_AUTOCONF += --with-builtin-arc4random
else
OPENNTPD_AUTOCONF += --without-builtin-arc4random
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openntpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, openntpd)
	@$(call install_fixup, openntpd,PRIORITY,optional)
	@$(call install_fixup, openntpd,SECTION,base)
	@$(call install_fixup, openntpd,AUTHOR,"Carsten Schlote c.schlote@konzeptpark.de>")
	@$(call install_fixup, openntpd,DESCRIPTION,missing)

	@$(call install_copy, openntpd, 0, 0, 0755, -, /usr/sbin/ntpd)

	#
	# config
	#

	@$(call install_alternative, openntpd, 0, 0, 0644, /etc/ntp-server.conf, n)

	#
	# busybox init
	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_OPENNTPD_STARTSCRIPT
	@$(call install_alternative, openntpd, 0, 0, 0644, /etc/init.d/ntp-server, n)
endif
endif

	@$(call install_finish, openntpd)

	@$(call touch)

# vim: syntax=make
