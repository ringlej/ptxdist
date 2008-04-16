# -*-makefile-*-
# $Id: template-make 8008 2008-04-15 07:39:46Z mkl $
#
# Copyright (C) 2006 by Robert Schwebel
#               2008 by Marc Kleine-Budde <mkl@pengutronix.de>
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
	$(CROSS_AUTOCONF_USR) \
	--enable-dynamic-linking \
	--disable-debug \
	--disable-sun-streams \
	--disable-sun-door

ifdef PTXCONF_SYSLOGNG__IPV6
SYSLOGNG_AUTOCONF += --enable-ipv6
else
SYSLOGNG_AUTOCONF += --disable-ipv6
endif

ifdef PTXCONF_SYSLOGNG__TCP_WRAPPER
SYSLOGNG_AUTOCONF += --enable-tcp-wrapper
else
SYSLOGNG_AUTOCONF += --disable-tcp-wrapper
endif

ifdef PTXCONF_SYSLOGNG__SPOOF_SOURCE
SYSLOGNG_AUTOCONF += --enable-spoof-source
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
	@$(call install_fixup, syslogng,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, syslogng,DEPENDS,)
	@$(call install_fixup, syslogng,DESCRIPTION,missing)

	@$(call install_copy, syslogng, 0, 0, 0755, \
		$(SYSLOGNG_DIR)/src/syslog-ng, /sbin/syslog-ng)

ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_STARTSCRIPT
ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_DEFAULT
# install the generic one
	@$(call install_copy, syslogng, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/syslog-ng, \
		/etc/init.d/syslog-ng, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_USER
# install users one
	@$(call install_copy, syslogng, 0, 0, 0755, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/syslog-ng, \
		/etc/init.d/syslog-ng, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_LINK),"")
	@$(call install_copy, syslogng, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, syslogng, ../init.d/syslog-ng, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_SYSLOGNG_CONFIG
ifdef PTXCONF_ROOTFS_ETC_SYSLOGNG_CONFIG_DEFAULT
# install the generic one
	@$(call install_copy, syslogng, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/syslog-ng.conf, \
		/etc/syslog-ng.conf, n)
endif
ifdef PTXCONF_ROOTFS_ETC_SYSLOGNG_CONFIG_USER
# install users one
	@$(call install_copy, syslogng, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/syslog-ng.conf, \
		/etc/syslog-ng.conf, n)
endif
endif

	@$(call install_finish, syslogng)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

syslogng_clean:
	rm -rf $(STATEDIR)/syslogng.*
	rm -rf $(IMAGEDIR)/syslogng_*
	rm -rf $(SYSLOGNG_DIR)

# vim: syntax=make
