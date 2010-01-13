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
PACKAGES-$(PTXCONF_XORG_LIB_DMX) += xorg-lib-dmx

#
# Paths and names
#
XORG_LIB_DMX_VERSION	:= 1.1.0
XORG_LIB_DMX		:= libdmx-$(XORG_LIB_DMX_VERSION)
XORG_LIB_DMX_SUFFIX	:= tar.bz2
XORG_LIB_DMX_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib//$(XORG_LIB_DMX).$(XORG_LIB_DMX_SUFFIX)
XORG_LIB_DMX_SOURCE	:= $(SRCDIR)/$(XORG_LIB_DMX).$(XORG_LIB_DMX_SUFFIX)
XORG_LIB_DMX_DIR	:= $(BUILDDIR)/$(XORG_LIB_DMX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_DMX_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_DMX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_DMX_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_DMX_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_DMX_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull \
	--disable-dependency-tracking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-dmx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-dmx)
	@$(call install_fixup, xorg-lib-dmx,PACKAGE,xorg-lib-dmx)
	@$(call install_fixup, xorg-lib-dmx,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-dmx,VERSION,$(XORG_LIB_DMX_VERSION))
	@$(call install_fixup, xorg-lib-dmx,SECTION,base)
	@$(call install_fixup, xorg-lib-dmx,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-dmx,DEPENDS,)
	@$(call install_fixup, xorg-lib-dmx,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-dmx, 0, 0, 0644, -, \
		/usr/lib/libdmx.so.1.0.0)
	@$(call install_link, xorg-lib-dmx, \
		libdmx.so.1.0.0, /usr/lib/libdmx.so.1)
	@$(call install_link, xorg-lib-dmx, \
		libdmx.so.1.0.0, /usr/lib/libdmx.so)

	@$(call install_finish, xorg-lib-dmx)

	@$(call touch)

# vim: syntax=make
