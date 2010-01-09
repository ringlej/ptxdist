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
XORG_PROTO_XCMISC_VERSION	:= 1.2.0
XORG_PROTO_XCMISC		:= xcmiscproto-$(XORG_PROTO_XCMISC_VERSION)
XORG_PROTO_XCMISC_SUFFIX	:= tar.bz2
XORG_PROTO_XCMISC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_XCMISC).$(XORG_PROTO_XCMISC_SUFFIX)
XORG_PROTO_XCMISC_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XCMISC).$(XORG_PROTO_XCMISC_SUFFIX)
XORG_PROTO_XCMISC_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XCMISC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_XCMISC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_XCMISC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_XCMISC_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_XCMISC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XCMISC_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-xcmisc.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xcmisc_clean:
	rm -rf $(STATEDIR)/xorg-proto-xcmisc.*
	rm -rf $(PKGDIR)/xorg-proto-xcmisc_*
	rm -rf $(XORG_PROTO_XCMISC_DIR)

# vim: syntax=make

