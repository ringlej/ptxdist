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
PACKAGES-$(PTXCONF_XORG_PROTO_SCRNSAVER) += xorg-proto-scrnsaver

#
# Paths and names
#
XORG_PROTO_SCRNSAVER_VERSION 	:= 1.2.2
XORG_PROTO_SCRNSAVER_MD5	:= edd8a73775e8ece1d69515dd17767bfb
XORG_PROTO_SCRNSAVER		:= scrnsaverproto-$(XORG_PROTO_SCRNSAVER_VERSION)
XORG_PROTO_SCRNSAVER_SUFFIX	:= tar.bz2
XORG_PROTO_SCRNSAVER_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_SCRNSAVER).$(XORG_PROTO_SCRNSAVER_SUFFIX))
XORG_PROTO_SCRNSAVER_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_SCRNSAVER).$(XORG_PROTO_SCRNSAVER_SUFFIX)
XORG_PROTO_SCRNSAVER_DIR	:= $(BUILDDIR)/$(XORG_PROTO_SCRNSAVER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_SCRNSAVER_CONF_TOOL	:= autoconf
XORG_PROTO_SCRNSAVER_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs \
	$(XORG_OPTIONS_DOCS)

# vim: syntax=make

