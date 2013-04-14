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
OPENNTPD_VERSION	:= 3.9p1
OPENNTPD_MD5		:= afc34175f38d08867c1403d9008600b3
OPENNTPD		:= openntpd-$(OPENNTPD_VERSION)
OPENNTPD_SUFFIX		:= tar.gz
OPENNTPD_URL		:= http://ftp.eu.openbsd.org/pub/OpenBSD/OpenNTPD/$(OPENNTPD).$(OPENNTPD_SUFFIX)
OPENNTPD_SOURCE		:= $(SRCDIR)/$(OPENNTPD).$(OPENNTPD_SUFFIX)
OPENNTPD_DIR		:= $(BUILDDIR)/$(OPENNTPD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
OPENNTPD_CONF_TOOL	:= autoconf
OPENNTPD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-privsep-user=ntp \
	--with-privsep-path=/var/run/ntp \
	--$(call ptx/wwo, PTXCONF_OPENNTPD_ARC4RANDOM)-builtin-arc4random

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
