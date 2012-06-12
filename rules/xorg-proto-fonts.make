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
PACKAGES-$(PTXCONF_XORG_PROTO_FONTS) += xorg-proto-fonts

#
# Paths and names
#
XORG_PROTO_FONTS_VERSION	:= 2.1.2
XORG_PROTO_FONTS_MD5		:= c5f4f1fb4ba7766eedbc9489e81f3be2
XORG_PROTO_FONTS		:= fontsproto-$(XORG_PROTO_FONTS_VERSION)
XORG_PROTO_FONTS_SUFFIX		:= tar.bz2
XORG_PROTO_FONTS_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_FONTS).$(XORG_PROTO_FONTS_SUFFIX))
XORG_PROTO_FONTS_SOURCE		:= $(SRCDIR)/$(XORG_PROTO_FONTS).$(XORG_PROTO_FONTS_SUFFIX)
XORG_PROTO_FONTS_DIR		:= $(BUILDDIR)/$(XORG_PROTO_FONTS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_FONTS_CONF_TOOL	:= autoconf
XORG_PROTO_FONTS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs \
	$(XORG_OPTIONS_DOCS)

# vim: syntax=make

