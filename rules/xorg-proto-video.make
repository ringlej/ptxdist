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
XORG_PROTO_VIDEO_VERSION:= 2.3.1
XORG_PROTO_VIDEO_MD5	:= c3b348c6e2031b72b11ae63fc7f805c2
XORG_PROTO_VIDEO	:= videoproto-$(XORG_PROTO_VIDEO_VERSION)
XORG_PROTO_VIDEO_SUFFIX	:= tar.bz2
XORG_PROTO_VIDEO_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_VIDEO).$(XORG_PROTO_VIDEO_SUFFIX)
XORG_PROTO_VIDEO_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_VIDEO).$(XORG_PROTO_VIDEO_SUFFIX)
XORG_PROTO_VIDEO_DIR	:= $(BUILDDIR)/$(XORG_PROTO_VIDEO)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_VIDEO_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_VIDEO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_VIDEO_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_VIDEO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_VIDEO_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-video.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

