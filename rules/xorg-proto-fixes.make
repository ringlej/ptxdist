# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2009 by Robert Schwebel
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
PACKAGES-$(PTXCONF_XORG_PROTO_FIXES) += xorg-proto-fixes

#
# Paths and names
#
XORG_PROTO_FIXES_VERSION	:= 5.0
XORG_PROTO_FIXES_MD5		:= e7431ab84d37b2678af71e29355e101d
XORG_PROTO_FIXES		:= fixesproto-$(XORG_PROTO_FIXES_VERSION)
XORG_PROTO_FIXES_SUFFIX		:= tar.bz2
XORG_PROTO_FIXES_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_FIXES).$(XORG_PROTO_FIXES_SUFFIX))
XORG_PROTO_FIXES_SOURCE		:= $(SRCDIR)/$(XORG_PROTO_FIXES).$(XORG_PROTO_FIXES_SUFFIX)
XORG_PROTO_FIXES_DIR		:= $(BUILDDIR)/$(XORG_PROTO_FIXES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_FIXES_CONF_TOOL := autoconf

# vim: syntax=make

