# -*-makefile-*-
#
# Copyright (C) 2009 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSOCKETCAN) += libsocketcan

#
# Paths and names
#
LIBSOCKETCAN_VERSION	:= 0.0.10
LIBSOCKETCAN_MD5	:= f8b41f6037b6d155bc305bdd32208ded
LIBSOCKETCAN		:= libsocketcan-$(LIBSOCKETCAN_VERSION)
LIBSOCKETCAN_SUFFIX	:= tar.bz2
LIBSOCKETCAN_URL	:= http://www.pengutronix.de/software/libsocketcan/download/$(LIBSOCKETCAN).$(LIBSOCKETCAN_SUFFIX)
LIBSOCKETCAN_SOURCE	:= $(SRCDIR)/$(LIBSOCKETCAN).$(LIBSOCKETCAN_SUFFIX)
LIBSOCKETCAN_DIR	:= $(BUILDDIR)/$(LIBSOCKETCAN)
LIBSOCKETCAN_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSOCKETCAN_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsocketcan.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsocketcan)
	@$(call install_fixup, libsocketcan,PRIORITY,optional)
	@$(call install_fixup, libsocketcan,SECTION,base)
	@$(call install_fixup, libsocketcan,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, libsocketcan,DESCRIPTION,missing)

	@$(call install_lib, libsocketcan, 0, 0, 0644, libsocketcan)

	@$(call install_finish, libsocketcan)

	@$(call touch)

# vim: syntax=make
