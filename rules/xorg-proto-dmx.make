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
PACKAGES-$(PTXCONF_XORG_PROTO_DMX) += xorg-proto-dmx

#
# Paths and names
#
XORG_PROTO_DMX_VERSION	:= 2.3.1
XORG_PROTO_DMX_MD5	:= 4ee175bbd44d05c34d43bb129be5098a
XORG_PROTO_DMX		:= dmxproto-$(XORG_PROTO_DMX_VERSION)
XORG_PROTO_DMX_SUFFIX	:= tar.bz2
XORG_PROTO_DMX_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_DMX).$(XORG_PROTO_DMX_SUFFIX))
XORG_PROTO_DMX_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_DMX).$(XORG_PROTO_DMX_SUFFIX)
XORG_PROTO_DMX_DIR	:= $(BUILDDIR)/$(XORG_PROTO_DMX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_DMX_CONF_TOOL := autoconf

# vim: syntax=make

