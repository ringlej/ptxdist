# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
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
PACKAGES-$(PTXCONF_XORG_LIB_XEVIE) += xorg-lib-xevie

#
# Paths and names
#
XORG_LIB_XEVIE_VERSION	:= 1.0.2
XORG_LIB_XEVIE		:= libXevie-$(XORG_LIB_XEVIE_VERSION)
XORG_LIB_XEVIE_SUFFIX	:= tar.bz2
XORG_LIB_XEVIE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XEVIE).$(XORG_LIB_XEVIE_SUFFIX)
XORG_LIB_XEVIE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XEVIE).$(XORG_LIB_XEVIE_SUFFIX)
XORG_LIB_XEVIE_DIR	:= $(BUILDDIR)/$(XORG_LIB_XEVIE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XEVIE_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XEVIE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XEVIE_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XEVIE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XEVIE_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xevie.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xevie)
	@$(call install_fixup, xorg-lib-xevie,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xevie,SECTION,base)
	@$(call install_fixup, xorg-lib-xevie,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xevie,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xevie, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXevie.so.1.0.0)

	@$(call install_link, xorg-lib-xevie, \
		libXevie.so.1.0.0, \
		$(XORG_LIBDIR)/libXevie.so.1)

	@$(call install_link, xorg-lib-xevie, \
		libXevie.so.1.0.0, \
		$(XORG_LIBDIR)/libXevie.so)

	@$(call install_finish, xorg-lib-xevie)

	@$(call touch)

# vim: syntax=make
