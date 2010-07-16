# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XI) += xorg-lib-xi

#
# Paths and names
#
XORG_LIB_XI_VERSION	:= 1.3
XORG_LIB_XI		:= libXi-$(XORG_LIB_XI_VERSION)
XORG_LIB_XI_SUFFIX	:= tar.bz2
XORG_LIB_XI_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XI).$(XORG_LIB_XI_SUFFIX)
XORG_LIB_XI_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XI).$(XORG_LIB_XI_SUFFIX)
XORG_LIB_XI_DIR		:= $(BUILDDIR)/$(XORG_LIB_XI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XI_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XI_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XI_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XI_AUTOCONF += --disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xi)
	@$(call install_fixup, xorg-lib-xi,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xi,SECTION,base)
	@$(call install_fixup, xorg-lib-xi,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xi,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xi, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXi.so.6.1.0)

	@$(call install_link, xorg-lib-xi, \
		libXi.so.6.1.0, \
		$(XORG_LIBDIR)/libXi.so.6)

	@$(call install_link, xorg-lib-xi, \
		libXi.so.6.1.0, \
		$(XORG_LIBDIR)/libXi.so)

	@$(call install_finish, xorg-lib-xi)

	@$(call touch)

# vim: syntax=make
