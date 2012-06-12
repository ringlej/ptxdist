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
PACKAGES-$(PTXCONF_XORG_PROTO_KB) += xorg-proto-kb

#
# Paths and names
#
XORG_PROTO_KB_VERSION 	:= 1.0.6
XORG_PROTO_KB_MD5	:= 677ea8523eec6caca86121ad2dca0b71
XORG_PROTO_KB		:= kbproto-$(XORG_PROTO_KB_VERSION)
XORG_PROTO_KB_SUFFIX	:= tar.bz2
XORG_PROTO_KB_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_KB).$(XORG_PROTO_KB_SUFFIX))
XORG_PROTO_KB_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_KB).$(XORG_PROTO_KB_SUFFIX)
XORG_PROTO_KB_DIR	:= $(BUILDDIR)/$(XORG_PROTO_KB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_KB_CONF_TOOL	:= autoconf
XORG_PROTO_KB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs \
	$(XORG_OPTIONS_DOCS)

# vim: syntax=make

