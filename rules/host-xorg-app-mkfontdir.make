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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_APP_MKFONTDIR) += host-xorg-app-mkfontdir

#
# Paths and names
#
HOST_XORG_APP_MKFONTDIR_DIR	= $(HOST_BUILDDIR)/$(XORG_APP_MKFONTDIR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-app-mkfontdir.get: $(STATEDIR)/xorg-app-mkfontdir.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_APP_MKFONTDIR_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_APP_MKFONTDIR_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_APP_MKFONTDIR_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
