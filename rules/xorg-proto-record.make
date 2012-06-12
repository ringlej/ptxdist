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
PACKAGES-$(PTXCONF_XORG_PROTO_RECORD) += xorg-proto-record

#
# Paths and names
#
XORG_PROTO_RECORD_VERSION	:= 1.14.2
XORG_PROTO_RECORD_MD5		:= 1b4e5dede5ea51906f1530ca1e21d216
XORG_PROTO_RECORD		:= recordproto-$(XORG_PROTO_RECORD_VERSION)
XORG_PROTO_RECORD_SUFFIX	:= tar.bz2
XORG_PROTO_RECORD_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_RECORD).$(XORG_PROTO_RECORD_SUFFIX))
XORG_PROTO_RECORD_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_RECORD).$(XORG_PROTO_RECORD_SUFFIX)
XORG_PROTO_RECORD_DIR		:= $(BUILDDIR)/$(XORG_PROTO_RECORD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_RECORD_CONF_TOOL	:= autoconf
XORG_PROTO_RECORD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs \
	$(XORG_OPTIONS_DOCS)

# vim: syntax=make

