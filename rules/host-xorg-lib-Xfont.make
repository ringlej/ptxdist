# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_XFONT) += host-xorg-lib-xfont

#
# Paths and names
#
HOST_XORG_LIB_XFONT_DIR		= $(HOST_BUILDDIR)/$(XORG_LIB_XFONT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-lib-xfont.get: $(STATEDIR)/xorg-lib-xfont.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_LIB_XFONT_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_XFONT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_XFONT_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-freetype

# vim: syntax=make
