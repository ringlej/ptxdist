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
PACKAGES-$(PTXCONF_XORG_PROTO_XINERAMA) += xorg-proto-xinerama

#
# Paths and names
#
XORG_PROTO_XINERAMA_VERSION 	:= 1.2.1
XORG_PROTO_XINERAMA_MD5		:= 9959fe0bfb22a0e7260433b8d199590a
XORG_PROTO_XINERAMA		:= xineramaproto-$(XORG_PROTO_XINERAMA_VERSION)
XORG_PROTO_XINERAMA_SUFFIX	:= tar.bz2
XORG_PROTO_XINERAMA_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_XINERAMA).$(XORG_PROTO_XINERAMA_SUFFIX))
XORG_PROTO_XINERAMA_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XINERAMA).$(XORG_PROTO_XINERAMA_SUFFIX)
XORG_PROTO_XINERAMA_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XINERAMA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_XINERAMA_CONF_TOOL := autoconf

# vim: syntax=make

