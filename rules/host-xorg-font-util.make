# -*-makefile-*-
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_FONT_UTIL) += host-xorg-font-util

#
# Paths and names
#
HOST_XORG_FONT_UTIL_DIR	= $(HOST_BUILDDIR)/$(XORG_FONT_UTIL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-font-util.get: $(STATEDIR)/xorg-font-util.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_FONT_UTIL_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_FONT_UTIL_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_FONT_UTIL_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-font-util_clean:
	rm -rf $(STATEDIR)/host-xorg-font-util.*
	rm -rf $(HOST_XORG_FONT_UTIL_DIR)

# vim: syntax=make
