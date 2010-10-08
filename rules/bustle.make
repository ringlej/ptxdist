# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BUSTLE) += bustle

#
# Paths and names
#
BUSTLE_VERSION	:= 0.2.2
BUSTLE_MD5	:= 68e8a5f75e04fa7004e6ef4d31a3aead
BUSTLE		:= bustle-$(BUSTLE_VERSION)
BUSTLE_SUFFIX	:= tar.gz
BUSTLE_URL	:= http://www.willthompson.co.uk/bustle/releases/$(BUSTLE).$(BUSTLE_SUFFIX)
BUSTLE_SOURCE	:= $(SRCDIR)/$(BUSTLE).$(BUSTLE_SUFFIX)
BUSTLE_DIR	:= $(BUILDDIR)/$(BUSTLE)
BUSTLE_LICENSE	:= GPLv2+, LGPLv2.1+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BUSTLE_SOURCE):
	@$(call targetinfo)
	@$(call get, BUSTLE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BUSTLE_PATH	:= PATH=$(CROSS_PATH)
BUSTLE_COMPILE_ENV := $(CROSS_ENV)

$(STATEDIR)/bustle.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bustle.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bustle.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bustle)
	@$(call install_fixup, bustle,PRIORITY,optional)
	@$(call install_fixup, bustle,SECTION,base)
	@$(call install_fixup, bustle,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, bustle,DESCRIPTION,missing)

	@$(call install_copy, bustle, 0, 0, 0755, $(BUSTLE_DIR)/bustle-dbus-monitor, /usr/bin/bustle-dbus-monitor)

	@$(call install_finish, bustle)

	@$(call touch)

# vim: syntax=make
