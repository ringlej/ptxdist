# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_X11) += host-xorg-lib-x11

#
# Paths and names
#
HOST_XORG_LIB_X11	= $(XORG_LIB_X11)
HOST_XORG_LIB_X11_DIR	= $(HOST_BUILDDIR)/$(HOST_XORG_LIB_X11)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-lib-x11.get: $(STATEDIR)/xorg-lib-x11.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_LIB_X11_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_X11_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_X11_AUTOCONF	:= \
	$(HOST_AUTOCONF) \
	--disable-man-pages \
	--disable-specs

# vim: syntax=make
