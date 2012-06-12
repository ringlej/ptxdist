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
PACKAGES-$(PTXCONF_XORG_PROTO_BIGREQS) += xorg-proto-bigreqs

#
# Paths and names
#
XORG_PROTO_BIGREQS_VERSION	:= 1.1.2
XORG_PROTO_BIGREQS_MD5		:= 1a05fb01fa1d5198894c931cf925c025
XORG_PROTO_BIGREQS		:= bigreqsproto-$(XORG_PROTO_BIGREQS_VERSION)
XORG_PROTO_BIGREQS_SUFFIX	:= tar.bz2
XORG_PROTO_BIGREQS_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_BIGREQS).$(XORG_PROTO_BIGREQS_SUFFIX))
XORG_PROTO_BIGREQS_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_BIGREQS).$(XORG_PROTO_BIGREQS_SUFFIX)
XORG_PROTO_BIGREQS_DIR		:= $(BUILDDIR)/$(XORG_PROTO_BIGREQS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_BIGREQS_CONF_TOOL	:= autoconf
XORG_PROTO_BIGREQS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs \
	$(XORG_OPTIONS_DOCS)

# vim: syntax=make

