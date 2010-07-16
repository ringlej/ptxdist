# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#               2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLUEZ_UTILS) += bluez-utils

#
# Paths and names
#
BLUEZ_UTILS_VERSION	:= 3.36
BLUEZ_UTILS		:= bluez-utils-$(BLUEZ_UTILS_VERSION)
BLUEZ_UTILS_SUFFIX	:= tar.gz
BLUEZ_UTILS_URL		:= http://bluez.sourceforge.net/download/$(BLUEZ_UTILS).$(BLUEZ_UTILS_SUFFIX)
BLUEZ_UTILS_SOURCE	:= $(SRCDIR)/$(BLUEZ_UTILS).$(BLUEZ_UTILS_SUFFIX)
BLUEZ_UTILS_DIR		:= $(BUILDDIR)/$(BLUEZ_UTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BLUEZ_UTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, BLUEZ_UTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BLUEZ_UTILS_PATH	:= PATH=$(CROSS_PATH)
BLUEZ_UTILS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
BLUEZ_UTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-alsa \
	--without-fuse \
	--without-openobex \
	--without-usb

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bluez-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bluez-utils)
	@$(call install_fixup, bluez-utils,PRIORITY,optional)
	@$(call install_fixup, bluez-utils,SECTION,base)
	@$(call install_fixup, bluez-utils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, bluez-utils,DESCRIPTION,missing)

	# FIXME: wait for patch from Sandro Noel
#	@$(call install_copy, bluez-utils, 0, 0, 0755, $(BLUEZ_UTILS_DIR)/foobar, /dev/null)

	@$(call install_finish, bluez-utils)

	@$(call touch)

# vim: syntax=make
