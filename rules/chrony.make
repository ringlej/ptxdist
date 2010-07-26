# -*-makefile-*-
#
# Copyright (C) 2005 by Bjoern Buerger <b.buerger@pengutronix.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CHRONY) += chrony

#
# Paths and names
#
CHRONY_VERSION	:= 1.24-pre1
CHRONY		:= chrony-$(CHRONY_VERSION)
CHRONY_SUFFIX	:= tar.gz
CHRONY_URL	:= http://download.tuxfamily.org/chrony/$(CHRONY).$(CHRONY_SUFFIX)
CHRONY_SOURCE	:= $(SRCDIR)/$(CHRONY).$(CHRONY_SUFFIX)
CHRONY_DIR	:= $(BUILDDIR)/$(CHRONY)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CHRONY_SOURCE):
	@$(call targetinfo)
	@$(call get, CHRONY)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CHRONY_PATH	:= PATH=$(CROSS_PATH)
CHRONY_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CHRONY_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-readline

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/chrony.targetinstall:
	@$(call targetinfo)

	@$(call install_init, chrony)
	@$(call install_fixup, chrony,PRIORITY,optional)
	@$(call install_fixup, chrony,SECTION,base)
	@$(call install_fixup, chrony,AUTHOR,"PTXdist Base Package <ptxdist@pengutronix.de>")
	@$(call install_fixup, chrony,DESCRIPTION,missing)

# binaries
	@$(call install_copy, chrony, 0, 0, 0755, -, \
		/usr/sbin/chronyd)
	@$(call install_copy, chrony, 0, 0, 0755, -, \
		/usr/bin/chronyc)

# command helper script
ifdef PTXCONF_CHRONY_INSTALL_CHRONY_COMMAND
	@$(call install_copy, chrony, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/usr/bin/chrony_command, \
		/usr/bin/chrony_command)
endif
ifdef PTXCONF_CHRONY_INSTALL_CHRONY_COMMAND
	@$(call install_copy, chrony, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/usr/bin/chrony_command, \
		/usr/bin/chrony_command)
endif

# chrony stat convenience wrapper
ifdef PTXCONF_CHRONY_INSTALL_CHRONY_STAT
	@$(call install_copy, chrony, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/usr/bin/chrony_stat, 	\
		/usr/bin/chrony_stat)
endif


# generic one
ifdef PTXCONF_CHRONY_DEFAULTCONFIG
	@$(call install_copy, chrony, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/chrony/chrony.conf, \
		/etc/chrony/chrony.conf)
	@$(call install_copy, chrony, 0, 0, 0600, \
		$(PTXDIST_TOPDIR)/generic/etc/chrony/chrony.keys, \
		/etc/chrony/chrony.keys)
endif

# users one
ifdef PTXCONF_CHRONY_USERCONFIG
	@$(call install_copy, chrony, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/chrony/chrony.conf, \
		/etc/chrony/chrony.conf)
	@$(call install_copy, chrony, 0, 0, 0600, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/chrony/chrony.keys, \
		/etc/chrony/chrony.keys)
endif

# modify placeholders with data from configuration
ifdef PTXCONF_CHRONY_INSTALL_CONFIG
	@$(call install_replace, chrony, /etc/chrony/chrony.conf, \
		@UNCONFIGURED_CHRONY_SERVER_IP@, $(PTXCONF_CHRONY_DEFAULT_NTP_SERVER))

	@$(call install_replace, chrony, /etc/chrony/chrony.keys, \
		@UNCONFIGURED_CHRONY_ACCESS_KEY@, $(PTXCONF_CHRONY_DEFAULT_ACCESS_KEY))
endif

#	#
#	# busybox init: startscripts
#	#
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_CHRONY_STARTSCRIPT
	@$(call install_alternative, chrony, 0, 0, 0755, /etc/init.d/chrony)

ifneq ($(call remove_quotes, $(PTXCONF_CHRONY_BBINIT_LINK)),)
	@$(call install_link, chrony, \
		../init.d/chrony, \
		/etc/rc.d/$(PTXCONF_CHRONY_BBINIT_LINK))
endif
endif
endif
	@$(call install_finish, chrony)

	@$(call touch)

# vim: syntax=make
