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
PACKAGES-$(PTXCONF_XORG_PROTO_GL) += xorg-proto-gl

#
# Paths and names
#
XORG_PROTO_GL_VERSION 	:= 1.4.17
XORG_PROTO_GL_MD5	:= 5565f1b0facf4a59c2778229c1f70d10
XORG_PROTO_GL		:= glproto-$(XORG_PROTO_GL_VERSION)
XORG_PROTO_GL_SUFFIX	:= tar.bz2
XORG_PROTO_GL_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_GL).$(XORG_PROTO_GL_SUFFIX))
XORG_PROTO_GL_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_GL).$(XORG_PROTO_GL_SUFFIX)
XORG_PROTO_GL_DIR	:= $(BUILDDIR)/$(XORG_PROTO_GL)
XORG_PROTO_GL_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_GL_CONF_TOOL := autoconf

# vim: syntax=make

