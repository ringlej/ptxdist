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
CHRONY_VERSION	:= 3.3
CHRONY_MD5	:= 81ab62cf5d60b4b3fa8cd2c1b267ffd9
CHRONY		:= chrony-$(CHRONY_VERSION)
CHRONY_SUFFIX	:= tar.gz
CHRONY_URL	:= http://download.tuxfamily.org/chrony/$(CHRONY).$(CHRONY_SUFFIX)
CHRONY_SOURCE	:= $(SRCDIR)/$(CHRONY).$(CHRONY_SUFFIX)
CHRONY_DIR	:= $(BUILDDIR)/$(CHRONY)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CHRONY_CONF_TOOL	:= autoconf
CHRONY_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-readline \
	--without-editline \
	--disable-sechash \
	--without-nettle \
	--without-nss \
	--without-tomcrypt \
	--disable-cmdmon \
	--disable-ntp \
	--disable-refclock \
	--disable-phc \
	--disable-pps \
	$(call ptx/ifdef PTXCONF_GLOBAL_IPV6,,--disable-ipv6) \
	--without-seccomp

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
	@$(call install_alternative, chrony, 0, 0, 0755, /usr/bin/chrony_command)
endif

# chrony stat convenience wrapper
ifdef PTXCONF_CHRONY_INSTALL_CHRONY_STAT
	@$(call install_alternative, chrony, 0, 0, 0755, /usr/bin/chrony_stat)
endif

# generic one
ifdef PTXCONF_CHRONY_INSTALL_CONFIG
	@$(call install_alternative, chrony, 0, 0, 0644, /etc/chrony/chrony.conf)
	@$(call install_alternative, chrony, 0, 0, 0600, /etc/chrony/chrony.keys)

# modify placeholders with data from configuration
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
