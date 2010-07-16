# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#               2007, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLUEZ_LIBS) += bluez-libs

#
# Paths and names
#
BLUEZ_LIBS_VERSION	:= 3.36
BLUEZ_LIBS		:= bluez-libs-$(BLUEZ_LIBS_VERSION)
BLUEZ_LIBS_SUFFIX	:= tar.gz
BLUEZ_LIBS_URL		:= http://bluez.sourceforge.net/download/$(BLUEZ_LIBS).$(BLUEZ_LIBS_SUFFIX)
BLUEZ_LIBS_SOURCE	:= $(SRCDIR)/$(BLUEZ_LIBS).$(BLUEZ_LIBS_SUFFIX)
BLUEZ_LIBS_DIR		:= $(BUILDDIR)/$(BLUEZ_LIBS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BLUEZ_LIBS_SOURCE):
	@$(call targetinfo)
	@$(call get, BLUEZ_LIBS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BLUEZ_LIBS_PATH	:= PATH=$(CROSS_PATH)
BLUEZ_LIBS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
BLUEZ_LIBS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bluez-libs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bluez-libs)
	@$(call install_fixup, bluez-libs,PRIORITY,optional)
	@$(call install_fixup, bluez-libs,SECTION,base)
	@$(call install_fixup, bluez-libs,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, bluez-libs,DESCRIPTION,missing)

	@$(call install_copy, bluez-libs, 0, 0, 0644, - ,\
		/usr/lib/libbluetooth.so.2.11.2)
	@$(call install_link, bluez-libs, libbluetooth.so.2.11.2, /usr/lib/libbluetooth.so.2)
	@$(call install_link, bluez-libs, libbluetooth.so.2.11.2, /usr/lib/libbluetooth.so)

	@$(call install_finish, bluez-libs)

	@$(call touch)

# vim: syntax=make
