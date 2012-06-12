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
PACKAGES-$(PTXCONF_XORG_PROTO_XCMISC) += xorg-proto-xcmisc

#
# Paths and names
#
XORG_PROTO_XCMISC_VERSION	:= 1.2.2
XORG_PROTO_XCMISC_MD5		:= 5f4847c78e41b801982c8a5e06365b24
XORG_PROTO_XCMISC		:= xcmiscproto-$(XORG_PROTO_XCMISC_VERSION)
XORG_PROTO_XCMISC_SUFFIX	:= tar.bz2
XORG_PROTO_XCMISC_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_XCMISC).$(XORG_PROTO_XCMISC_SUFFIX))
XORG_PROTO_XCMISC_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XCMISC).$(XORG_PROTO_XCMISC_SUFFIX)
XORG_PROTO_XCMISC_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XCMISC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_XCMISC_CONF_TOOL	:= autoconf
XORG_PROTO_XCMISC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs \
	$(XORG_OPTIONS_DOCS)

# vim: syntax=make

