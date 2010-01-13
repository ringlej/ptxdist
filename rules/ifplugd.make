# -*-makefile-*-
#
# Copyright (C) 2007 by Ladislav Michl
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IFPLUGD) += ifplugd

#
# Paths and names
#
IFPLUGD_VERSION	:= 0.28
IFPLUGD		:= ifplugd-$(IFPLUGD_VERSION)
IFPLUGD_SUFFIX	:= tar.gz
IFPLUGD_URL	:= http://0pointer.de/lennart/projects/ifplugd/$(IFPLUGD).$(IFPLUGD_SUFFIX)
IFPLUGD_SOURCE	:= $(SRCDIR)/$(IFPLUGD).$(IFPLUGD_SUFFIX)
IFPLUGD_DIR	:= $(BUILDDIR)/$(IFPLUGD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(IFPLUGD_SOURCE):
	@$(call targetinfo)
	@$(call get, IFPLUGD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IFPLUGD_PATH	:= PATH=$(CROSS_PATH)
IFPLUGD_ENV 	:= \
	$(CROSS_ENV)

#
# autoconf
#
IFPLUGD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-lynx

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ifplugd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ifplugd)
	@$(call install_fixup, ifplugd,PACKAGE,ifplugd)
	@$(call install_fixup, ifplugd,PRIORITY,optional)
	@$(call install_fixup, ifplugd,VERSION,$(IFPLUGD_VERSION))
	@$(call install_fixup, ifplugd,SECTION,base)
	@$(call install_fixup, ifplugd,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ifplugd,DEPENDS,)
	@$(call install_fixup, ifplugd,DESCRIPTION,missing)

	@$(call install_copy, ifplugd, 0, 0, 0755, -, /usr/sbin/ifplugd)
	@$(call install_copy, ifplugd, 0, 0, 0755, -, /etc/ifplugd/ifplugd.action, n)

ifdef PTXCONF_IFPLUGD_STATUS
	@$(call install_copy, ifplugd, 0, 0, 0755, -, /usr/sbin/ifplugstatus)
endif

	@$(call install_finish, ifplugd)

	@$(call touch)

# vim: syntax=make
