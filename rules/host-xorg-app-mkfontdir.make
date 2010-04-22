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
HOST_XORG_APP_MKFONTDIR_DEVPKG	= NO

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XORG_APP_MKFONTDIR_CONFTOOL	:= autoconf

# vim: syntax=make
