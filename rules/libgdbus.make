# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGDBUS) += libgdbus

#
# Paths and names
#
LIBGDBUS_VERSION	:= 0.2
LIBGDBUS_MD5		:= 775a41347751d0b0169d6bace03c1361
LIBGDBUS		:= libgdbus-$(LIBGDBUS_VERSION)
LIBGDBUS_SUFFIX		:= tar.bz2
LIBGDBUS_URL		:= $(PTXCONF_SETUP_KERNELMIRROR)/bluetooth/$(LIBGDBUS).$(LIBGDBUS_SUFFIX)
LIBGDBUS_SOURCE		:= $(SRCDIR)/$(LIBGDBUS).$(LIBGDBUS_SUFFIX)
LIBGDBUS_DIR		:= $(BUILDDIR)/$(LIBGDBUS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBGDBUS_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBGDBUS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGDBUS_PATH	:= PATH=$(CROSS_PATH)
LIBGDBUS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGDBUS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-debug \
	--with-gnu-ld

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgdbus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgdbus)
	@$(call install_fixup, libgdbus,PRIORITY,optional)
	@$(call install_fixup, libgdbus,SECTION,base)
	@$(call install_fixup, libgdbus,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libgdbus,DESCRIPTION,missing)

	@$(call install_lib, libgdbus, 0, 0, 0644, libgdbus)

	@$(call install_finish, libgdbus)

	@$(call touch)

# vim: syntax=make
