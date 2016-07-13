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
PACKAGES-$(PTXCONF_XORG_PROTO_VIDEO) += xorg-proto-video

#
# Paths and names
#
XORG_PROTO_VIDEO_VERSION:= 2.3.2
XORG_PROTO_VIDEO_MD5	:= e658641595327d3990eab70fdb55ca8b
XORG_PROTO_VIDEO	:= videoproto-$(XORG_PROTO_VIDEO_VERSION)
XORG_PROTO_VIDEO_SUFFIX	:= tar.bz2
XORG_PROTO_VIDEO_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_VIDEO).$(XORG_PROTO_VIDEO_SUFFIX))
XORG_PROTO_VIDEO_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_VIDEO).$(XORG_PROTO_VIDEO_SUFFIX)
XORG_PROTO_VIDEO_DIR	:= $(BUILDDIR)/$(XORG_PROTO_VIDEO)
XORG_PROTO_VIDEO_LICENSE := MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_VIDEO_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-video.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

