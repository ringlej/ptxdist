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
PACKAGES-$(PTXCONF_LIBMODBUS) += libmodbus

#
# Paths and names
#
LIBMODBUS_VERSION	:= 2.0.4
LIBMODBUS_MD5		:= 6b3aa500ab441a953eeb73a8c58cdf76
LIBMODBUS		:= libmodbus-$(LIBMODBUS_VERSION)
LIBMODBUS_SUFFIX	:= tar.gz
LIBMODBUS_URL		:= http://launchpad.net/libmodbus/trunk/2.0.3/+download/$(LIBMODBUS).$(LIBMODBUS_SUFFIX)
LIBMODBUS_SOURCE	:= $(SRCDIR)/$(LIBMODBUS).$(LIBMODBUS_SUFFIX)
LIBMODBUS_DIR		:= $(BUILDDIR)/$(LIBMODBUS)
LIBMODBUS_LICENSE	:= LGPLv3

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBMODBUS_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBMODBUS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------


LIBMODBUS_PATH	:= PATH=$(CROSS_PATH)
LIBMODBUS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBMODBUS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmodbus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmodbus)
	@$(call install_fixup, libmodbus,PRIORITY,optional)
	@$(call install_fixup, libmodbus,SECTION,base)
	@$(call install_fixup, libmodbus,AUTHOR,"Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>")
	@$(call install_fixup, libmodbus,DESCRIPTION,missing)

	@$(call install_lib, libmodbus, 0, 0, 0644, libmodbus)

	@$(call install_finish, libmodbus)

	@$(call touch)

# vim: syntax=make
