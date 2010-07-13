# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSLOGNG) += syslogng

#
# Paths and names
#
SYSLOGNG_VERSION	:= 2.0.9
SYSLOGNG		:= syslog-ng-$(SYSLOGNG_VERSION)
SYSLOGNG_SUFFIX		:= tar.gz
SYSLOGNG_URL		:= http://www.balabit.com/downloads/files/syslog-ng/sources/2.0/src/$(SYSLOGNG).$(SYSLOGNG_SUFFIX)
SYSLOGNG_SOURCE		:= $(SRCDIR)/$(SYSLOGNG).$(SYSLOGNG_SUFFIX)
SYSLOGNG_DIR		:= $(BUILDDIR)/$(SYSLOGNG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SYSLOGNG_SOURCE):
	@$(call targetinfo)
	@$(call get, SYSLOGNG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SYSLOGNG_PATH	:= PATH=$(CROSS_PATH)
SYSLOGNG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SYSLOGNG_AUTOCONF := \
	$(CROSS_AUTOCONF_ROOT) \
	$(GLOBAL_IPV6_OPTION) \
	--enable-dynamic-linking \
	--disable-debug \
	--disable-sun-streams \
	--disable-sun-door

ifdef PTXCONF_SYSLOGNG_TCP_WRAPPER
SYSLOGNG_AUTOCONF += --enable-tcp-wrapper
else
SYSLOGNG_AUTOCONF += --disable-tcp-wrapper
endif

ifdef PTXCONF_SYSLOGNG_SPOOF_SOURCE
SYSLOGNG_AUTOCONF += \
	--enable-spoof-source \
	--with-libnet=$(SYSROOT)/usr/bin
else
SYSLOGNG_AUTOCONF += --disable-spoof-source
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/syslogng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, syslogng)
	@$(call install_fixup, syslogng,PACKAGE,syslogng)
	@$(call install_fixup, syslogng,PRIORITY,optional)
	@$(call install_fixup, syslogng,VERSION,$(SYSLOGNG_VERSION))
	@$(call install_fixup, syslogng,SECTION,base)
	@$(call install_fixup, syslogng,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, syslogng,DEPENDS,)
	@$(call install_fixup, syslogng,DESCRIPTION,missing)

#	# binary
	@$(call install_copy, syslogng, 0, 0, 0755, -, \
		/sbin/syslog-ng)

#	# config
ifdef PTXCONF_SYSLOGNG_CONFIG
	@$(call install_alternative, syslogng, 0, 0, 0644, /etc/syslog-ng.conf, n)
endif

#	# bb init: start scripts
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_SYSLOGNG_STARTSCRIPT
	@$(call install_alternative, syslogng, 0, 0, 0755, /etc/init.d/syslog-ng, n)
endif
endif
	@$(call install_finish, syslogng)

	@$(call touch)

# vim: syntax=make
